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
                <div class="modal-title" style="margin-bottom: 30px;">
                  <%= @title %>
                  <a href="#" style="position: relative; left: 40%;" title="Fermer" phx-click="left-button-click" phx-target={"#modal-#{@id}"}><i class="bi bi-x"></i></a>
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
                        <div class="row">
                          <div class="column column-10">
                            <label>Nom: </label>
                            </div>
                            <div class="column column-65">
                            <%= @card.name %>
                            </div>
                        </div>
                      </div>

                      <div class="column">
                      <div class="row">
                        <div class="column column-40">
                          <label>Attributeur:</label>
                          </div>
                          <div class="column column-25">
                          <%= @card.task.attributor.username %>
                          </div>
                          <div class="column column-35" style="position: relative; top: -7px;">
                            <img class="profile-pic-mini" src={Routes.static_path(@socket, "/#{@card.task.attributor.profile_picture}")} width="50"/>
                          </div>
                      </div>
                      </div>

                    </div>
                    <!-- END OF FIRST ROW -->

                      <!-- CONTRIBUTOR ROW -->
                        <%= if @card.task.contributor != nil do  %>

                        <div class="row">

                          <div class="column">

                          </div>

                          <div class="column">
                          <div class="row">
                            <div class="column column-40">
                              <label>Contributeur: </label>
                              </div>
                              <div class="column column-25">
                              <%= @card.task.contributor.username %>
                              </div>
                              <div class="column column-35" style="position: relative; top: -7px; left: 3px;">
                                <img class="profile-pic-mini" src={Routes.static_path(@socket, "/#{@card.task.contributor.profile_picture}")} width="50"/>
                              </div>
                          </div>
                          </div>

                        </div>

                        <% end %>
                        <!-- END OF CONTRIBUTOR ROW -->

                      <!-- SECOND ROW -->
                        <div class="row" style="margin-bottom: 10px;">

                          <div class="column">
                            <div class="row">
                              <div class="column column-10">
                                <label>Statut:</label>
                                </div>
                                <div class="column column-65">
                                <%= @card.task.status.title %>
                                </div>
                            </div>
                          </div>

                          <div class="column">
                            <div class="row">
                              <div class="column column-10">
                                <label>Priorité:</label>
                                </div>
                                <div class="column column-65">
                                <%= @card.task.priority.title %>
                                </div>
                            </div>
                          </div>

                        </div>
                        <!-- END OF SECOND ROW -->

                          <!-- THIRD ROW -->
                            <div class="row">

                              <div class="column">
                                    <label>Date de début:</label>
                                    <%= Utilities.letters_date_format(@card.task.date_start) %>
                              </div>

                              <div class="column">
                                    <label>Date de fin:</label>
                                    <%= if @card.task.date_end != nil do
                                          Utilities.letters_date_format(@card.task.date_end)
                                        else
                                          "En attente"
                                        end %>
                              </div>

                            </div>
                          <!-- END OF THIRD ROW -->

                            <!-- FOURTH ROW -->
                              <div class="row">

                                <div class="column">
                                      <label>Durée estimée:</label>
                                      <p><%= @card.task.estimated_duration %> heure</p>
                                </div>

                                <div class="column">
                                      <label>Durée effectuée:</label>
                                      <p><%= @card.task.performed_duration%> heure</p>
                                </div>

                              </div>
                            <!-- END OF FOURTH ROW -->

                              <!-- FOURTH ROW -->
                                <div class="row">

                                  <div class="column">
                                        <label>Progression</label>
                                        <p><%= @card.task.progression%> %</p>
                                  </div>

                                  <div class="column">
                                        <label>Date d'échéance:</label>
                                        <p><%= Utilities.letters_date_format(@card.task.deadline)%></p>
                                  </div>

                                </div>
                              <!-- END OF FOURTH ROW -->

                              <!-- FIFTH ROW -->
                              <div class="row">
                              <label>Nombre approximatif d'heures par jour ouvrable
                               pour l'intervenant pour terminer cette tâche avant la date d'échéance:
                              </label>
                              </div>

                              <!--END OF FIFTH ROW -->

                              <!-- SIXTH ROW -->
                              <div class="row">
                                <div class="column">
                                  <p><%= PmLogin.Monitoring.avg_working_hours(@card.task) %> heure</p>
                                </div>
                              </div>


                              <!-- END OF SIXTH ROW -->

                    <!-- Buttons -->

                      <button class="btn btn-lg left-button" type="button" phx-click="left-button-click" phx-target={"#modal-#{@id}"}>
                        <div>
                          <%= @left_button %>
                        </div>
                      </button>

                      <div class="row">
                        <div class="column column-50">
                        </div>
                        <div class="column column-50">
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
