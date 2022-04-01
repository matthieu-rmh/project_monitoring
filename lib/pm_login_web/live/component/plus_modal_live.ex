defmodule PmLoginWeb.LiveComponent.PlusModalLive do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Form
  import PmLoginWeb.ErrorHelpers
  alias PmLoginWeb.Router.Helpers, as: Routes
  alias PmLogin.Utilities

  @defaults %{
    left_button: "Cancel",
    left_button_action: nil,
    left_button_param: nil,
    right_button: "OK",
    right_button_action: nil,
    right_button_param: nil
  }

  # render modal
  @spec render(map()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
      <div id={"modal-#{@id}"}>
        <!-- Modal Background -->
        <div id="plus_modal_container" class="modal-container" style={"visibility: #{if @show_plus_modal, do: "visible", else: "hidden" }; opacity: #{ if @show_plus_modal, do: "1 !important", else: "0" };"}
            phx-hook="ScrollLock">
            <%= if not is_nil(@card) do %>
          <div class="modal-inner-container">
            <div class="modal-card-task">
              <div class="modal-inner-card">
                <!-- Title -->
                <%= if @title != nil do %>
                <div class="modal-title" style="margin-top: 5px; margin-bottom: 15px;">
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

                  <!-- FIRST ROW -->
                    <div class="row">
                      <div class="column">
                          <label class="zoom-out"> Nom </label>
                          <div class="zoom-out text-break"><%= @card.name %></div>
                      </div>

                      <div class="column">
                        <label class="zoom-out">Attributeur </label>
                        <div>
                          <img class="profile-pic-mini" src={Routes.static_path(@socket, "/#{@card.task.attributor.profile_picture}")} width="36"/>
                        </div>
                        <div class="zoom-out">
                          <%= @card.task.attributor.username %>
                        </div>
                      </div>

                      <div>
                        <%= if @card.task.contributor != nil do  %>
                          <div class="column">
                            <label class="zoom-out">Contributeur</label>
                            <div>
                              <img class="profile-pic-mini" src={Routes.static_path(@socket, "/#{@card.task.contributor.profile_picture}")} width="36"/>
                            </div>
                            <div class="zoom-out">
                              <%= @card.task.contributor.username %>
                            </div>
                          </div>
                        <% end %>
                      </div>

                    </div>

                        <div class="row" style="margin-top: 6px;">

                          <div class="column">
                            <label class="zoom-out">Statut</label>
                            <div class="zoom-out">
                              <%= @card.task.status.title %>
                            </div>
                          </div>

                          <div class="column">
                            <div class="column">
                              <label class="zoom-out">Priorité</label>
                            </div>
                            <div class="column">
                              <div class="zoom-out">
                              <%= case @card.task.priority.title do %>
                                <% "Faible" -> %>
                                  <div class="task-small">
                                    <%= @card.task.priority.title %>
                                  </div>
                                <% "Moyenne" -> %>
                                  <div class="task-average">
                                    <%= @card.task.priority.title %>
                                  </div>
                                <% "Importante" -> %>
                                  <div class="task-important">
                                    <%= @card.task.priority.title %>
                                  </div>
                                <% "Urgente" -> %>
                                  <div class="task-urgent">
                                    <%= @card.task.priority.title %>
                                  </div>
                                <% _ -> %>
                                  <div>
                                    <p> Priorité non reconnu </p>
                                  </div>
                              <% end %>
                              </div>
                            </div>
                          </div>

                        </div>
                        <!-- END OF SECOND ROW -->

                          <!-- THIRD ROW -->
                            <div class="row" style="margin-top: 6px;">
                              <div class="column">
                                <label class="zoom-out">Date de début</label>
                                <div class="zoom-out">
                                  <%= Utilities.letters_date_format(@card.task.date_start) %>
                                </div>
                              </div>

                              <div class="column">
                                <label class="zoom-out">Date de fin</label>
                                <div class="zoom-out">
                                  <%= if @card.task.date_end != nil do
                                    Utilities.letters_date_format(@card.task.date_end)
                                  else
                                    "En attente"
                                  end %>
                                </div>
                              </div>

                            </div>
                          <!-- END OF THIRD ROW -->

                            <!-- FOURTH ROW -->
                              <div class="row" style="margin-top: 6px;">

                                <div class="column">
                                  <label class="zoom-out">Durée estimée</label>
                                  <p class="zoom-out"> <%= @card.task.estimated_duration %> heure</p>
                                </div>

                                <div class="column">
                                  <label class="zoom-out">Durée effectuée</label>
                                  <p class="zoom-out"><%= @card.task.performed_duration%> heure</p>
                                </div>

                              </div>
                            <!-- END OF FOURTH ROW -->

                              <!-- FOURTH ROW -->
                                <div class="row" style="margin-top: -17px;">

                                  <div class="column">
                                    <label class="zoom-out">Progression</label>
                                    <div class="zoom-out"><%= @card.task.progression%> %</div>
                                  </div>

                                  <div class="column">
                                    <label class="zoom-out">Date d'échéance</label>
                                    <div class="zoom-out"><%= Utilities.letters_date_format(@card.task.deadline)%></div>
                                  </div>
                                </div>

                                <div class="row" style="margin-top: 6px; margin-bottom: 6px">
                                  <div class="column">
                                    <label class="zoom-out">Description</label>
                                    <div class="text-break zoom-out"> <%= @card.task.description %> </div>
                                  </div>
                                </div>
                              <!-- END OF FOURTH ROW -->

                              <!-- FIFTH ROW -->
                              <div class="zoom-out" style="margin-bottom: 6px">
                                Nombre approximatif d'heures par jour ouvrable pour l'intervenant pour terminer cette tâche avant la date d'échéance:
                              </div>
                              <p class="column zoom-out task-working-hours" style="margin-bottom: 10px"><%= PmLogin.Monitoring.avg_working_hours(@card.task) %> heures</p>



                              <!-- END OF SIXTH ROW -->

                    <!-- Buttons -->

                      <button class="button button-outline" type="button" phx-click="left-button-click" phx-target={"#modal-#{@id}"}>
                        <div>
                          <%= @left_button %>
                        </div>
                      </button>

                      <div class="row">
                        <div class="column column-100">
                          <i style="font-size: 10px;">Créee le <%= Utilities.simple_date_format_with_hours(@card.task.inserted_at) %>
                          </i>
                        </div>
                      </div>

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
