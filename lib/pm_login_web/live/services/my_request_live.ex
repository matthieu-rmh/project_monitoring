defmodule PmLoginWeb.Services.MyRequestsLive do
  use Phoenix.LiveView
  alias PmLogin.Services
  alias PmLogin.Monitoring
  alias PmLogin.Services
  alias PmLogin.Services.ClientsRequest
  alias PmLoginWeb.Router.Helpers, as: Routes
  alias PmLoginWeb.LiveComponent.DetailModalRequestLive

  alias PmLogin.Uuid

  def mount(_params, %{"curr_user_id" => curr_user_id}, socket) do
    Monitoring.subscribe()

    Services.subscribe()
    Services.subscribe_to_request_topic()

    {:ok,
     socket
     |> assign(
       display_form: false,
       changeset: Services.change_clients_request(%ClientsRequest{}),
       show_modal: false,
       service_id: nil,
       curr_user_id: curr_user_id,
       show_notif: false,
       notifs: Services.list_my_notifications_with_limit(curr_user_id, 4),
       requests: Services.list_my_requests(curr_user_id),
       show_detail_request_modal: false,
       client_request: nil
     )
     |> allow_upload(:file,
       accept:
         ~w(.png .jpeg .jpg .pdf .txt .odt .ods .odp .csv .xml .xls .xlsx .ppt .pptx .doc .docx),
       max_entries: 5
     ), layout: {PmLoginWeb.LayoutView, "active_client_layout_live.html"}}
  end

  def handle_event("modal_close", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("show_detail_request_modal", %{"id" => id}, socket) do
    client_request = Services.list_clients_requests_with_client_name_and_id(id)

    {:noreply, socket |> assign(show_detail_request_modal: true, client_request: client_request)}
  end

  def handle_event("cloture-request", %{"id" => id}, socket) do
    request = Services.get_request_with_user_id!(id)

    Services.update_request_bool(request, %{"finished" => true})

    # Mettre à jour la date de cloture du requête
    Services.update_clients_request(request, %{"date_finished" => NaiveDateTime.local_now()})

    {:noreply, socket |> put_flash(:info, "La requête #{request.title} a été cloturée")}
  end

  def handle_info({DetailModalRequestLive, :button_clicked, %{action: "cancel", param: nil}}, socket) do
    {:noreply, assign(socket, show_detail_request_modal: false)}
  end

  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, socket |> cancel_upload(:file, ref)}
  end

  def handle_event("cancel-request", %{"key" => key}, socket) do
    case key do
      "Escape" ->
        {:noreply, socket |> assign(display_form: false)}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_event("cancel-request", %{}, socket) do
    {:noreply, socket}
  end

  def handle_event("form-on", _params, socket) do
    {:noreply,
      socket
      |> clear_flash()
      |> assign(display_form: true)}
  end

  def handle_event("form-off", _params, socket) do
    {:noreply, socket |> assign(display_form: false)}
  end

  def handle_event("change-request", params, socket) do
    # IO.inspect(params)
    {:noreply, socket}
  end

  def handle_event("send-request", %{"clients_request" => params}, socket) do
    # Added uuid to the current params
    params = Map.put_new(params, "uuid", Uuid.generate)

    {entries, []} = uploaded_entries(socket, :file)
    # IO.inspect(entries)

    # urls = for entry <- entries do
    #   Routes.static_path(socket, "/uploads/#{entry.uuid}#{Path.extname(entry.client_name)}")
    # end

    # IO.inspect urls

    # consume_uploaded_entries(socket, :file, fn meta, entry ->
    #   dest = Path.join("priv/static/uploads", "#{entry.uuid}#{Path.extname(entry.client_name)}")
    #   File.cp!(meta.path, dest)
    #  end)
    # IO.inspect socket.assigns.uploads[:file].entries

    case Services.create_clients_request(params) do
      {:ok, result} ->
        consume_uploaded_entries(socket, :file, fn meta, entry ->
          ext = Path.extname(entry.client_name)
          file_name = Path.basename(entry.client_name, ext)
          dest = Path.join("priv/static/uploads", "#{file_name}#{entry.uuid}#{ext}")
          File.cp!(meta.path, dest)
        end)

        {entries, []} = uploaded_entries(socket, :file)

        urls =
          for entry <- entries do
            ext = Path.extname(entry.client_name)
            file_name = Path.basename(entry.client_name, ext)
            Routes.static_path(socket, "/uploads/#{file_name}#{entry.uuid}#{ext}")
          end

        Services.update_request_files(result, %{"file_urls" => urls})

        {:ok, result} |> Services.broadcast_request()
        # sending notifs to admins
        curr_user_id = socket.assigns.curr_user_id
        the_client = Services.get_active_client_from_userid!(curr_user_id)

        Services.send_notifs_to_admins(
          curr_user_id,
          "Le client #{the_client.user.username} de la société #{the_client.company.name} a envoyé une requête intitulée \"#{result.title}\".",
          5
        )

        Monitoring.broadcast_clients_requests({:ok, :clients_requests})

        {:noreply,
         socket
         |> assign(
           display_form: false,
           changeset: Services.change_clients_request(%ClientsRequest{})
         )
         |> put_flash(:info, "Requête envoyée")
         |> push_event("AnimateAlert", %{})}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(changeset: changeset)}
    end
  end

  def handle_info({"request_topic", [:request, :sent], _}, socket) do
    {:noreply, socket |> assign(requests: Services.list_my_requests(socket.assigns.curr_user_id))}
  end

  def handle_info({"request_topic", [:request, :updated], _}, socket) do
    {:noreply, socket |> assign(requests: Services.list_my_requests(socket.assigns.curr_user_id))}
  end

  def handle_info({Monitoring, [:request, :created], _}, socket) do
    {:noreply, socket |> assign(clients_requests: Services.list_clients_requests_with_client_name)}
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

  def handle_info({Services, [:notifs, :sent], _}, socket) do
    curr_user_id = socket.assigns.curr_user_id
    length = socket.assigns.notifs |> length

    {:noreply,
     socket |> assign(notifs: Services.list_my_notifications_with_limit(curr_user_id, length))}
  end

  def render(assigns) do
    PmLoginWeb.ClientsRequestView.render("my_demands.html", assigns)
  end
end
