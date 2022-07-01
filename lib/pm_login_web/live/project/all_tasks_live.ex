defmodule PmLoginWeb.Project.AllTasksLive do
  use Phoenix.LiveView
  alias PmLogin.Services
  alias PmLogin.Login
  alias PmLogin.Login.{User}
  alias PmLogin.Monitoring
  alias PmLogin.Monitoring.{Task, Priority}
  alias PmLogin.Services


  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Services.subscribe()
    Monitoring.subscribe()

    statuses = Monitoring.list_statuses()

    task_changeset = Monitoring.change_task(%Task{})
    modif_changeset = Monitoring.change_task(%Task{})

    priorities = Monitoring.list_priorities()
    list_priorities = Enum.map(priorities, fn %Priority{} = p -> {p.title, p.id} end)

    attributors = Login.list_attributors()
    list_attributors = Enum.map(attributors, fn %User{} = a -> {a.username, a.id} end)

    contributors = Login.list_contributors()
    list_contributors = Enum.map(contributors, fn %User{} = p -> {p.username, p.id} end)


    socket =
      socket
      |> assign(
        curr_user_id: curr_user_id,
        tasks: Monitoring.list_all_tasks_with_card(),
        statuses: statuses,
        tasks_not_achieved: Monitoring.list_tasks_attributed_not_achieved(curr_user_id),
        is_attributor: Monitoring.is_attributor?(curr_user_id),
        is_admin: Monitoring.is_admin?(curr_user_id),
        contributors: list_contributors,
        attributors: list_attributors,
        priorities: list_priorities,
        is_contributor: Monitoring.is_contributor?(curr_user_id),
        task_changeset: task_changeset,
        modif_changeset: modif_changeset,
        statuses: statuses,
        curr_user_id: curr_user_id,
        show_notif: false,

        # Par défault, on n'affiche pas show_plus_modal
        show_modif_menu: false,
        show_comments_menu: false,
        show_plus_modal: false,
        delete_task_modal: false,
        arch_id: nil,
        card_with_comments: nil,
        card: nil,
        showing_my_attributes: false,
        showing_my_tasks: true,
        notifs: Services.list_my_notifications_with_limit(curr_user_id, 4)
      )


    {:ok, socket, layout: {PmLoginWeb.LayoutView, "admin_layout_live.html"}}
  end

  # def handle_info({Monitoring, [_, _], _}, socket) do
  #   socket =
  #     socket
  #     |> assign(
  #       list_projects: Monitoring.list_projects,
  #       list_tasks: Monitoring.list_tasks,
  #       list_tasks_updated_today: Monitoring.list_tasks_filtered_by_date_today,
  #       list_tasks_achieved: Monitoring.list_tasks_achieved_order_by_updated_at,
  #       list_tasks_updated_yesterday: Monitoring.list_tasks_updated_yesterday
  #     )

  #   {:noreply, socket}
  # end

  def render(assigns) do
    PmLoginWeb.ProjectView.render("all_tasks.html", assigns)
  end
end
