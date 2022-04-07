defmodule PmLoginWeb.Project.ContributorTasksLive do
  use Phoenix.LiveView
  alias PmLogin.Services
  alias PmLogin.Monitoring
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

  def render(assigns) do
   PmLoginWeb.ContributorView.render("my_tasks.html", assigns)
  end
end
