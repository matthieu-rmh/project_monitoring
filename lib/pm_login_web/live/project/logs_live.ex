defmodule PmLoginWeb.Project.LogsLive do
  use Phoenix.LiveView
  alias PmLogin.Services
  alias PmLogin.Login
  alias PmLogin.Monitoring


  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Services.subscribe()
    Monitoring.subscribe()

    labels_tasks_by_contributors =
      for contributor <- Login.list_contributors_users_by_username do
        elem(contributor, 0)
      end

    values_tasks_by_contributors =
      for contributor <- Login.list_contributors_users_by_username do
        contributor_id = elem(contributor, 1)

        Monitoring.list_tasks_by_contributor_or_attributor(contributor_id)
        |> Enum.count()
      end

    values_tasks_todo_by_month =
      for month <- Enum.to_list(1..12) do
        Monitoring.list_tasks_by_month(1, month)
        |> Enum.count()
      end

    values_blocking_tasks_by_month =
      for month <- Enum.to_list(1..12) do
        Monitoring.list_tasks_by_month(2, month)
        |> Enum.count()
      end

    values_tasks_in_progress_by_month =
      for month <- Enum.to_list(1..12) do
        Monitoring.list_tasks_by_month(3, month)
        |> Enum.count()
      end

    values_tasks_in_control_by_month =
      for month <- Enum.to_list(1..12) do
        Monitoring.list_tasks_by_month(4, month)
        |> Enum.count()
      end

    values_tasks_achieved_by_month =
      for month <- Enum.to_list(1..12) do
        Monitoring.list_tasks_by_month(5, month)
        |> Enum.count()
      end


    socket =
      socket
      |> assign(
          show_dashboard_component: true,
          show_project_component: false,
          show_task_component: false,
          show_user_component: false,
          curr_user_id: curr_user_id,
          list_projects: Monitoring.list_projects,
          list_tasks: Monitoring.list_tasks,
          list_tasks_updated_today: Monitoring.list_tasks_filtered_by_date_today,
          list_tasks_updated_yesterday: Monitoring.list_tasks_updated_yesterday,
          list_tasks_updated_a_month_ago: Monitoring.list_tasks_updated_a_month_ago,
          list_tasks_not_achieved: Monitoring.list_tasks_order_by_updated_at,
          list_tasks_achieved: Monitoring.list_tasks_achieved_order_by_updated_at,
          list_tasks_by_contributor_id: nil,
          list_tasks_filtered_by_date: nil,
          list_admins: Login.list_admins_users,
          list_attributors: Login.list_attributors_users,
          list_contributors: Login.list_contributors_users,
          list_clients: Login.list_clients_users,
          list_unattributed: Login.list_unattributed_users,
          list_notifications_updated_today: Services.list_notifications_updated_today,
          list_notifications_updated_yesterday: Services.list_notifications_updated_yesterday,
          show_notif: false,
          notifs: Services.list_my_notifications_with_limit(curr_user_id, 4),
          chart_data: %{
            labels_tasks_by_contributors: labels_tasks_by_contributors,
            values_tasks_by_contributors: values_tasks_by_contributors,
            values_tasks_todo_by_month: values_tasks_todo_by_month,
            values_blocking_tasks_by_month: values_blocking_tasks_by_month,
            values_tasks_in_progress_by_month: values_tasks_in_progress_by_month,
            values_tasks_in_control_by_month: values_tasks_in_control_by_month,
            values_tasks_achieved_by_month: values_tasks_achieved_by_month,
          },
          loading: false
       )

    if {curr_user_id} in Login.list_ids_from_attributors_users do
      {:ok, socket, layout: {PmLoginWeb.LayoutView, "attributor_layout_live.html"}}
    else
      {:ok, socket, layout: {PmLoginWeb.LayoutView, "board_layout_live.html"}}
    end

  end


  # Affichage des notifications
  def handle_event("switch-notif", %{}, socket) do
    notifs_length = socket.assigns.notifs |> length
    curr_user_id = socket.assigns.curr_user_id
    switch =
      if socket.assigns.show_notif do
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

  def handle_event("cancel-notif", %{}, socket) do
    {:noreply, socket}
  end


  # Filtrer la liste des contributeurs par contributor_id
  def handle_event("logs_filtered_by_contributors", %{"_target" => ["contributor_select"], "contributor_select" => contributor_id}, socket) do
    list_tasks_by_contributor_id =
      case contributor_id do
        "9000" ->
          Monitoring.list_tasks_order_by_updated_at

        "-1" ->
          Monitoring.list_tasks_without_contributor

        _ ->
          Monitoring.list_tasks_by_contributor_id(contributor_id)
      end

    {:noreply, socket |> assign(list_tasks: list_tasks_by_contributor_id)}
  end


  def handle_event("show-project-component", _params, socket) do
    socket =
      socket
      |> assign(
          show_dashboard_component: false,
          show_project_component: true,
          show_task_component: false,
          show_user_component: false
        )

    {:noreply, socket}
  end

  def handle_event("show-task-component", _params, socket) do
    if not connected?(socket) do
      {:noreply, socket |> assign(loading: true)}
    else
      socket =
        socket
        |> assign(
            show_dashboard_component: false,
            show_project_component: false,
            show_task_component: true,
            show_user_component: false
          )

      {:noreply, socket |> assign(loading: false)}
    end
  end

  def handle_event("show-dashboard-component", _params, socket) do
    socket =
      socket
      |> assign(
          show_dashboard_component: true,
          show_project_component: false,
          show_task_component: false,
          show_user_component: false
        )

    {:noreply, socket}
  end

  def handle_event("show-user-component", _params, socket) do
    socket =
      socket
      |> assign(
          show_dashboard_component: false,
          show_project_component: false,
          show_task_component: false,
          show_user_component: true
        )

    {:noreply, socket}
  end

  # Charger les nouvelles donéées dans la base de données sans recharger la page
  def handle_info({Services, [:notifs, :sent], _}, socket) do
    socket =
      socket
      |> assign(
        list_notifications_updated_today: Services.list_notifications_updated_today,
        list_notifications_updated_yesterday: Services.list_notifications_updated_yesterday
      )

    {:noreply, socket}
  end

  def handle_info({Monitoring, [_, _], _}, socket) do
    socket =
      socket
      |> assign(
        list_projects: Monitoring.list_projects,
        list_tasks: Monitoring.list_tasks,
        list_tasks_updated_today: Monitoring.list_tasks_filtered_by_date_today,
        list_tasks_achieved: Monitoring.list_tasks_achieved_order_by_updated_at,
        list_tasks_updated_yesterday: Monitoring.list_tasks_updated_yesterday
      )

    {:noreply, socket}
  end

  def render(assigns) do
    if connected?(assigns.socket) do
      PmLoginWeb.ProjectView.render("logs.html", assigns)
    else
      PmLoginWeb.ProjectView.render("loading.html", assigns)
    end
  end
end
