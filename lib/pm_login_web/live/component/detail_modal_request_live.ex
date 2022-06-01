defmodule PmLoginWeb.LiveComponent.DetailModalRequestLive do
  use Phoenix.LiveComponent
  alias PmLogin.Utilities

  @defaults %{
    left_button: "Cancel",
    left_button_action: nil,
    left_button_param: nil,
    right_button: "OK",
    right_button_action: nil,
    right_button_param: nil
  }

  def render(assigns) do
    ~H"""
    <div id={"modal-#{@id}"}>
      <!-- Modal Background -->
      <div
        id="task_modal_container"
        class="modal-container"
        style={
                "visibility: #{ if @show_detail_request_modal, do: "visible", else: "hidden" };
                 opacity: #{ if @show_detail_request_modal, do: "1 !important", else: "0" };"
              }
      >
      <%= if not is_nil(@client_request) do %>
        <div class="modal-inner-container" phx-window-keydown="modal_close">
          <div class="modal-card-task" style="min-width: 450px;">
            <div class="modal-inner-card">
              <!-- Title -->
              <%= if @title != nil do %>
              <div class="modal-title">
                <%= @title %>
                <a href="#" class="x__close" style="position: relative; left: 0; margin-top: -5px;" title="Fermer" phx-click="left-button-click" phx-target={"#modal-#{@id}"}><i class="bi bi-x"></i></a>
              </div>
              <% end %>

              <!-- Body -->
              <%= if @body != nil do %>
              <div class="modal-body">
                <%= @body %>
              </div>
              <% end %>

              <!-- MY FORM -->
              <div class="modal-body">
                <table class="table-tasks-mobile" style="font-size: 11px; margin-bottom: 5px;">
                  <thead>
                    <tr>
                      <th>Client</th>
                      <th>Titre</th>
                      <th>Description</th>
                      <th>Date d'envoi</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td data-label="Client" style="word-wrap: anywhere;">
                      <%= @client_request.active_client.user.username %>
                      </td>
                      <td data-label="Titre" style="word-wrap: anywhere;">
                        <%= @client_request.title %>
                      </td>
                      <td data-label="Description">
                        <div style="word-wrap: anywhere;">
                          <%= @client_request.content %>
                        </div>
                      </td>
                      <td data-label="Date d'envoi"> <%= Utilities.letters_date_format_with_hours(@client_request.date_post) %> </td>
                      <!--
                      <td data-label="Fichiers">
                      </td>
                      -->
                      <%= if @client_request.content == nil or @client_request.content == " " or @client_request.content == [] do %>
                        <td data-label="Description" style="word-wrap: anywhere;">
                            Aucune description
                        </td>
                      <% end %>
                    </tr>
                  </tbody>
                </table>

                <button
                  class="button button-outline"
                  type="button"
                  phx-click="left-button-click"
                  phx-target={"#modal-#{@id}"}
                  style="margin: 1rem 0 0 0"
                >
                  <div>
                    <%= @left_button %>
                  </div>
                </button>

              </div>

            </div>
          </div>
        </div>
      <% end %>
      </div>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{id: _id} = assigns, socket) do
    {:ok, assign(socket, Map.merge(@defaults, assigns))}
  end

  # Fired when user clicks right button on modal
  def handle_event(
        "right-button-click",
        _params,
        %{
          assigns: %{
            right_button_action: right_button_action,
            right_button_param: right_button_param
          }
        } = socket
      ) do
    send(
      self(),
      {__MODULE__, :button_clicked, %{action: right_button_action, param: right_button_param}}
    )

    {:noreply, socket}
  end

  def handle_event(
        "left-button-click",
        _params,
        %{
          assigns: %{
            left_button_action: left_button_action,
            left_button_param: left_button_param
          }
        } = socket
      ) do
    send(
      self(),
      {__MODULE__, :button_clicked, %{action: left_button_action, param: left_button_param}}
    )

    {:noreply, socket}
  end
end
