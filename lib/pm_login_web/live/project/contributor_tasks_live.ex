defmodule PmLoginWeb.Project.ContributorTasksLive do
  use Phoenix.LiveView

  import Phoenix.HTML.Link
  # import Phoenix.HTML.Form

  alias PmLogin.Services
  alias PmLogin.Monitoring
  alias PmLogin.Kanban
  alias PmLoginWeb.Router.Helpers, as: Routes

  def mount(_params, %{"curr_user_id" => curr_user_id, "tasks" => tasks}, socket) do
    Monitoring.subscribe()
    Services.subscribe()

    statuses = Monitoring.list_statuses_for_tasks_table()

    {:ok,
     socket
     |> assign(
       tasks: tasks,
       curr_user_id: curr_user_id,
       statuses: statuses,
       show_notif: false,
       notifs: Services.list_my_notifications_with_limit(curr_user_id, 4)
     ), layout: {PmLoginWeb.LayoutView, "contributor_layout_live.html"}}
  end

  def handle_event("status_and_progression_changed", params, socket) do
    task = Monitoring.get_task_with_card!(params["task_id"])

    # Récupérer l'id de la dernière stage
    stage_end_id = Monitoring.get_achieved_stage_id_from_project_id!(task.project_id)

    curr_user_id = socket.assigns.curr_user_id

    status_id = params["status_id"]

    project = Monitoring.get_project_with_tasks!(task.project_id)

    Kanban.put_card_to_achieve(
      task.card,
      %{
        "stage_id" =>
        case status_id do
          "1" -> stage_end_id - 4
          "2" -> stage_end_id - 3
          "3" -> stage_end_id - 2
          "4" -> stage_end_id - 1
          _ -> nil
        end
      }
    )

    Monitoring.update_task(task, %{"status_id" => status_id})
    Monitoring.update_task_progression(task, %{"progression" => params["progression_change"]})

    Monitoring.broadcast_progression_change({:ok, task})

    if Monitoring.is_a_child?(task) do
      Monitoring.update_mother_task_progression(task, curr_user_id)
    end

    if Monitoring.is_task_primary?(task) do
      Monitoring.add_progression_to_project(project)
    end

    if Monitoring.is_task_mother?(task) do
      Monitoring.achieve_children_tasks(task, curr_user_id)
    end

    {:noreply, socket}
  end

  def handle_event("switch-notif", %{}, socket) do
    notifs_length = socket.assigns.notifs |> length
    curr_user_id = socket.assigns.curr_user_id

    switch =
      if socket.assigns.show_notif do
        ids =
          socket.assigns.notifs
          |> Enum.filter(fn x -> !x.seen end)
          |> Enum.map(fn x -> x.id end)

        Services.put_seen_some_notifs(ids)
        false
      else
        true
      end

    {:noreply,
     socket
     |> assign(
       show_notif: switch,
       notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length)
     )}
  end

  def handle_event("load-notifs", %{}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    notifs_length = socket.assigns.notifs |> length

    {:noreply,
     socket
     |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length + 4))
     |> push_event("SpinTest", %{})}
  end

  def handle_event("cancel-notif", %{}, socket) do
    cancel = if socket.assigns.show_notif, do: false
    {:noreply, socket |> assign(show_notif: cancel)}
  end

  def handle_info({Monitoring, [_, _], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    tasks = Monitoring.list_tasks_by_contributor_project(curr_user_id)

    IO.puts("handle_info...")

    {:noreply, socket |> assign(tasks: tasks)}
  end

  # def handle_info({Monitoring, [:task, :updated], _}, socket) do
  #   curr_user_id = socket.assigns.curr_user_id
  #   tasks = Monitoring.list_tasks_by_contributor_project(curr_user_id)

  #   IO.puts("faaaaaaaaa")

  #   {:noreply, socket |> assign(tasks: tasks)}
  # end

  def handle_info({Services, [:notifs, :sent], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    length = socket.assigns.notifs |> length

    {:noreply,
     socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, length))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <!-- <h3>
        <i class="bi bi-list-task"></i>
        Les tâches qui m'ont été assigné
      </h3> -->

      <%= if @tasks == [] do %>
        <div class="alert-primary" role="alert">
          <i title="Se déconnecter" class="bi bi-info-circle" style="font-size: 20px"></i>
          <div class="alert-text"> Aucune tâche n'a été assignée pour le moment... </div>
        </div>
      <% else %>
        <table class="table-tasks" id="" style="font-size: 12px;">
          <thead>
            <tr>
              <th>Projet</th>
              <th>Nom</th>
              <!-- <th>Description</th> -->
              <th>Statut</th>
              <th>Priorité</th>
              <th>Date de début</th>
              <th>Date d'échéance</th>
              <th>Progression</th>
            </tr>
          </thead>
          <tbody>
            <%= for task <- @tasks do %>
              <!-- Afficher les tâches si son statut est différent de Achevée(s) et que c'est pas archivé -->
              <%= if task.status_id != 5 and task.hidden == false do %>
                <tr>
                  <td data-label="Projet"> <%= task.project.title %> </td>
                  <td data-label="Nom" style="word-wrap: anywhere; min-width: 150px;">
                    <%= link task.title, to: Routes.project_path(@socket, :board, task.project_id) %>
                  </td>
                  <!-- <td data-label="Description" style="word-wrap: anywhere"><%= task.description %></td> -->
                  <form phx-change="status_and_progression_changed" style="margin-top: 23px;">
                    <td data-label="Status" style="min-width: 75px;">
                      <input type="hidden" value={task.id} name="task_id"/>
                      <input type="hidden" value={task.card} name="card_id" />
                      <select name="status_id" id="status_change_id"  style="color: #fff;">
                          <%= for status <- @statuses do %>
                            <%= if status.title == task.status.title do %>
                              <option value={status.id} selected>
                                <%= status.title %>
                              </option>
                            <% else %>
                              <option value={status.id} >
                                <%= status.title %>
                              </option>
                            <% end %>
                          <% end %>
                      </select>
                    </td>
                    <td data-label="Priorité" style="min-width: 100px;">
                      <%= case task.priority_id do %>
                        <% 1 -> %>
                          <div class="low__priority__point__bg">
                            <span class="low__priority__point__t"></span>
                            Faible
                          </div>
                        <% 2 -> %>
                          <div class="avg__priority__point__bg">
                            <span class="avg__priority__point__t"></span>
                            Moyenne
                          </div>
                        <% 3 -> %>
                          <div class="high__priority__point__bg">
                            <span class="high__priority__point__t"></span>
                            Importante
                          </div>
                        <% 4 -> %>
                          <div class="urg__priority__point__bg">
                            <span class="urg__priority__point__t"></span>
                            Urgente
                          </div>
                        <% _ -> %>
                          <div class="priority__point__bg">
                            <span class="priority__point__t"></span>
                          </div>
                      <% end %>
                    </td>
                    <td data-label="Date de début"> <%= Calendar.strftime(task.date_start, "%d-%m-%Y") %> </td>
                    <td data-label="Date d'échéance"> <%= Calendar.strftime(task.deadline, "%d-%m-%Y") %> </td>
                    <td data-label="Progression">
                      <input name="progression_change" type="number" value={task.progression} style="width: 75px; color: #fff;"/>
                    </td>
                  </form>
                </tr>
              <% end %>
            <% end %>
          </tbody>
        </table>
      <% end %>
    </div>
    """
  end
end
