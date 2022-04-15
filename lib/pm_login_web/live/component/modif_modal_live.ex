defmodule PmLoginWeb.LiveComponent.ModifModalLive do
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
      <div id="modif_modal_container" class="modal-container" style={"visibility: #{ if @show_modif_modal, do: "visible", else: "hidden" }; opacity: #{ if @show_modif_modal, do: "1 !important", else: "0" };"}
          phx-hook="ScrollLock">
        <%= if not is_nil(@card) do %>
        <div class="modal-inner-container">
          <div class="modal-card-task">
            <div class="modal-inner-card" style="width: 500px;">
              <!-- Title -->
              <%= if @title != nil do %>
              <div class="modal-title" style="margin-top: 5px; margin-bottom: 10px;">
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

              <.form let={f} for={@modif_changeset} phx-submit="update_task" novalidate>
                <%= hidden_input f, :task_id,value: @card.task.id %>

                    <div id="form">
                        <div class="row">
                          <div class="column">
                            <label class="zoom-out">Nom</label>
                            <div class="zoom-out">
                              <%= text_input f, :title, [value: @card.name] %>
                              <%= error_tag f, :title %>
                            </div>

                            <label class="zoom-out">Description</label>
                            <div class="zoom-out">
                              <%= textarea f, :description, [value: @card.task.description] %>
                              <%= error_tag f, :description %>
                            </div>
                          </div>

                          <div class="column">
                            <label class="zoom-out">Attributeur</label>
                            <div>
                              <img class="profile-pic-mini" src={Routes.static_path(@socket, "/#{@card.task.attributor.profile_picture}")} width="36"/>
                            </div>
                            <div class="zoom-out">
                              <%= @card.task.attributor.username %>
                            </div>
                          </div>
                      </div>

                      <div class="row">
                        <div class="column">
                          <label class="zoom-out"> Durée estimée (en heure) </label>
                            <%= if @is_admin or @is_attributor do %>
                                <b class="zoom-out"><%= number_input f, :estimated_duration, style: "width: 70px", value: @card.task.estimated_duration %> h</b>
                                <b class="zoom-out"> <%= error_tag f, :negative_estimated %> </b>
                            <% else %>
                                <b class="zoom-out"><%= @card.task.estimated_duration %></b>
                            <% end %>
                        </div>

                        <div class="column">
                          <label class="zoom-out">Durée effectuée</label>
                          <%= if @is_contributor do %>
                            <b class="zoom-out"><%= number_input f, :performed_duration, style: "width: 70px", value: @card.task.performed_duration %> h</b>
                            <p class="zoom-out"> <%= error_tag f, :negative_performed%> </p>
                          <% else %>
                            <b class="zoom-out"><%= @card.task.performed_duration %> h</b>
                          <% end %>
                        </div>
                      </div>

                      <div class="row">
                        <div class="column">
                            <%= if @is_admin or @is_attributor do %>
                              <label class="zoom-out">Assigner contributeur</label>
                              <%= select f, :contributor_id, @contributors, prompt: "Contributeurs:", selected: @card.task.contributor_id, style: "width: -moz-available;" %>
                              <%= error_tag f, :contributor_id %>
                            <% else %>
                              <label class="zoom-out">Contributeur</label>

                              <%= if !is_nil(@card.task.contributor_id) do %>
                                <p class="zoom-out"> <%= @card.task.contributor.username %> </p>
                                <% else %>
                                <p class="zoom-out"> <%= "Pas d'intervenant" %> </p>
                              <% end %>
                            <% end %>
                        </div>

                        <div class="column">
                          <label class="zoom-out">Priorité</label>
                          <%= if @is_contributor and is_nil(@card.task.parent_id) do %>
                            <p class="zoom-out"><%= @card.task.priority.title %></p>
                          <% else %>
                            <%= select f, :priority_id, @priorities, value: @card.task.priority_id, style: "width: -moz-available;" %>
                          <% end %>
                        </div>
                      </div>

                      <div class="row">
                        <div class="column">
                        <label class="zoom-out">Date de début</label>
                          <%= if (@is_admin or @is_attributor)do %>
                            <%= date_input f, :date_start, value: @card.task.date_start %>
                          <% else %>
                            <p class="zoom-out"><%= Utilities.letters_date_format(@card.task.date_start) %></p>
                          <% end %>
                        </div>

                        <div class="column">
                        <label class="zoom-out">Date de fin</label>
                          <%= if @is_contributor and @card.task.status_id == 4 do %>
                            <%= date_input f, :date_end, value: @card.task.date_end %>
                            <%= error_tag f, :dt_end_lt_start %>
                          <% else %>
                              <%= if !is_nil(@card.task.date_end) do %>
                                <p class="zoom-out"> <%= Utilities.letters_date_format(@card.task.date_end) %></p>
                              <% else %>
                                <p class="zoom-out">En attente</p>
                              <% end %>
                          <% end %>
                        </div>
                      </div>

                      <div class="row">
                        <div class="column">
                        <label class="zoom-out">Progression</label>
                          <b><%= number_input f, :progression, value: @card.task.progression, style: "width: 70px; margin-left: 20px;" %> %</b>
                          <div class="zoom-out">
                            <%= error_tag f, :invalid_progression %>
                            <%= error_tag f, :progression_not_int %>
                          </div>
                        </div>

                        <div class="column">
                          <%= if (@is_admin or @is_attributor) do %>
                            <label class="zoom-out">Date d'écheance</label>
                            <%= date_input f, :deadline, value: @card.task.deadline %>
                            <div class="zoom-out">
                              <%= error_tag f, :deadline %>
                              <%= error_tag f, :deadline_lt %>
                              <%= error_tag f, :deadline_before_dtstart %>
                            </div>
                          <% end %>
                        </div>
                      </div>

                      <%= if @card.task.without_control and @is_contributor and @card.task.status_id != 5 do %>
                        <button type="button" class="btn btn-lg btn-success" phx-click="achieve" phx-value-id={@card.task.id}>Achever</button>
                      <% end %>

                      <div class="modal-buttons">
                        <!-- Left Button -->
                        <button class="button button-outline"
                                type="button"
                                phx-click="left-button-click"
                                phx-target={"#modal-#{@id}"}>
                          <div>
                            <%= @left_button %>
                          </div>
                        </button>
                          <div class="">
                            <%= submit "Valider", class: "button right-button" %>
                          </div>
                      </div>

                    </div>
              </.form>
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
