defmodule PmLoginWeb.Services.SurveyRequestLive do
  use PmLoginWeb, :live_view

  alias PmLogin.Services
  alias PmLoginWeb.ClientsRequestView

  #====== Mount ======#
  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Services.subscribe()
    Services.subscribe_to_request_topic()

    {:ok,
     socket
     |> assign(search_text: nil)
     |> assign(
       requests: Services.list_requests(),
       show_detail_request_modal: false,
       client_request: nil,
       show_modal: false,
       service_id: nil,
       curr_user_id: curr_user_id,
       show_notif: false,
       notifs: Services.list_my_notifications_with_limit(curr_user_id, 4)
     ), layout: {PmLoginWeb.LayoutView, "admin_layout_live.html"}}
  end

  #===========================#
  # Switch Notification Event #
  #===========================#
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

  #============================#
  # Loading Notification Event #
  #============================#
  def handle_event("load-notifs", %{}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    notifs_length = socket.assigns.notifs |> length

    {:noreply,
     socket
     |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, notifs_length + 4))
     |> push_event("SpinTest", %{})}
  end

  #===========================#
  # Cancel Notification Event #
  #===========================#
  def handle_event("cancel-notif", %{}, socket) do
    cancel = if socket.assigns.show_notif, do: false
    {:noreply, socket |> assign(show_notif: cancel)}
  end

  #====== Render ======#
  def render(assigns) do
    ClientsRequestView.render("survey_request.html", assigns)
  end
end
