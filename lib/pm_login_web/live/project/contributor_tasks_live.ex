defmodule PmLoginWeb.Project.ContributorTasksLive do
  use Phoenix.LiveView

  import Phoenix.HTML.Link
  import Phoenix.HTML.Form

  alias PmLogin.Services
  alias PmLogin.Monitoring
  alias PmLoginWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~H"""
    <h3><i class="bi bi-list-task"></i> Les tâches qui m'ont été assigné </h3>
      <table class="table-tasks" id="tb-auth" style="font-size: 12px;">
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
            <th></th>
          </tr>
        </thead>
        <tbody>
          <%= for task <- @tasks do %>
            <!-- Afficher les valeurs si son statut différent de Achevée(s) et que c'est pas archivé -->
            <%= if task.status_id != 5 and task.hidden == false do %>
              <tr>
                <td data-label="Projet" style="margin-left: 15px;"> <%= task.project.title %> </td>
                <td data-label="Nom" style="word-wrap: anywhere; min-width: 250px;"><%= link "#{task.title}", to: Routes.project_path(@socket, :board, task.project_id) %></td>
                <!-- <td data-label="Description" style="word-wrap: anywhere"><%= task.description %></td> -->
                <td data-label="Status" style="min-width: 75px">
                  <select name="" id="">
                    <%= for status <- Monitoring.list_statuses_for_task do %>
                      <%= if status.title == task.status.title do %>
                        <option selected>
                          <%= task.status.title %>
                        </option>
                      <% else %>
                        <option>
                          <%= status.title %>
                        </option>
                      <% end %>
                    <% end %>
                  </select>
                </td>
                <td data-label="Priorité">
                  <%= case task.priority_id do %>
                    <% 1 -> %> <div class="low__priority__point__table"> Faible</div>
                    <% 2 -> %> <div class="avg__priority__point__table"> Moyenne</div>
                    <% 3 -> %><div class="high__priority__point__table"> Importante</div>
                    <% 4 -> %><div class="urg__priority__point__table"> Urgente</div>
                    <% _ -> %><div class="priority__point__table"></div>
                  <% end %>
                </td>
                <td data-label="Date de début"> <%= Calendar.strftime(task.date_start, "%d-%m-%Y") %> </td>
                <td data-label="Date d'échéance"> <%= Calendar.strftime(task.deadline, "%d-%m-%Y") %> </td>
                <td data-label="Progression">
                  <input type="number" value={task.progression} style="width: 75px"/>
                </td>
              </tr>
            <% end %>
          <% end %>
        </tbody>
      </table>
    """
  end

  def mount(_params, %{"curr_user_id"=>curr_user_id, "tasks" => tasks}, socket) do
    Monitoring.subscribe()
    Services.subscribe()

    {:ok,
       socket
       |> assign(
                tasks: tasks,
                curr_user_id: curr_user_id,
                show_notif: false,
                notifs: Services.list_my_notifications_with_limit(curr_user_id, 4)
                ),
          layout: {PmLoginWeb.LayoutView, "contributor_layout_live.html"}
    }
  end

  def handle_event("switch-notif", %{}, socket) do
    notifs_length = socket.assigns.notifs |> length
    curr_user_id = socket.assigns.curr_user_id
    switch = if socket.assigns.show_notif do
              ids = socket.assigns.notifs
                    |> Enum.filter(fn(x) -> !(x.seen) end)
                    |> Enum.map(fn(x) -> x.id  end)
              Services.put_seen_some_notifs(ids)
                false
              else
                true
             end
    {:noreply, socket |> assign(show_notif: switch, notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length))}
  end

  def handle_event("load-notifs", %{}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    notifs_length = socket.assigns.notifs |> length
    {:noreply, socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length+4)) |> push_event("SpinTest", %{})}
  end

  def handle_event("cancel-notif", %{}, socket) do
    cancel = if socket.assigns.show_notif, do: false
    {:noreply, socket |> assign(show_notif: cancel)}
  end

  def handle_info({Monitoring, [_, _], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    tasks = Monitoring.list_tasks_by_contributor_project(curr_user_id)

    IO.puts("faaaaaaaaa")

    {:noreply, socket |> assign(tasks: tasks)}
  end

  def handle_info({Monitoring, [:task, :updated], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    tasks = Monitoring.list_tasks_by_contributor_project(curr_user_id)

    IO.puts("faaaaaaaaa")

    {:noreply, socket |> assign(tasks: tasks)}
  end

  def handle_info({Services, [:notifs, :sent], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    length = socket.assigns.notifs |> length
    {:noreply, socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, length))}
  end
end
