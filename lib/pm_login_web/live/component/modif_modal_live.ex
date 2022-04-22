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
                 <table class="table-tasks-mobile" style="font-size: 11px;">
                    <thead>
                      <tr>
                        <th>Nom</th>
                        <th>Attributeur</th>
                        <th>Contributeur</th>
                        <th>Priorité</th>
                        <th>Date de début</th>
                        <th>Date de fin</th>
                        <th>Durée estimée</th>
                        <th>Progression</th>
                        <th>Date d'échéance</th>
                        <th>Description</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td data-label="Nom">
                          <input id="task_title" name="task[title]" type="text" value={@card.name} style="width: 350px; margin-bottom: 0;" placeholder="Nom de la tâche"/>
                          <span class="invalid-feedback" phx-feedback-for="task_title" style="margin: 5 0 0 0;">Nom de tâche ne doit pas être vide!</span>
                        </td>
                        <td data-label="Description">
                          <input id="task_description" name="task[description]" value={@card.task.description} style="width: 350px; margin-bottom: 0;" placeholder="Description"/>
                          <%= error_tag f, :description %>
                        </td>
                        <td data-label="Attributeur">
                          <div style="display: inline-flex;">
                            <img class="profile-pic-mini" style="width: 20px; height: 20px;"
                                src={Routes.static_path(@socket, "/#{@card.task.attributor.profile_picture}")}/>

                            <div style="margin-top: 2px; margin-left: 5px;">
                              <%= @card.task.attributor.username %>
                            </div>
                          </div>
                        </td>
                        <td data-label="Contributeur">
                          <%= if @is_admin or @is_attributor do %>
                            <%= select f, :contributor_id, @contributors, prompt: "Contributeurs:", selected: @card.task.contributor_id, style: "width: 200px; margin-bottom: 0;" %>
                            <%= error_tag f, :contributor_id %>
                          <% else %>
                            <%= if !is_nil(@card.task.contributor_id) do %>
                              <%= @card.task.contributor.username %>
                            <% else %>
                              class="zoom-out"> <%= "Pas d'intervenant" %>
                            <% end %>
                          <% end %>
                        </td>
                        <td data-label="Priorité">
                          <%= if @is_contributor and is_nil(@card.task.parent_id) do %>
                            <%= @card.task.priority.title %>
                          <% else %>
                            <%= select f, :priority_id, @priorities, value: @card.task.priority_id, style: "width: 150px; margin-bottom: 0;" %>
                          <% end %>
                        </td>
                        <td data-label="Date de début">
                          <%= if (@is_admin or @is_attributor)do %>
                            <%= date_input f, :date_start, value: @card.task.date_start, style: "width: 150px; margin-bottom: 0;"%>
                          <% else %>
                            <%= Utilities.letters_date_format(@card.task.date_start) %>
                          <% end %>
                        </td>
                        <td data-label="Date d'échéance">
                        <%= if (@is_admin or @is_attributor) do %>
                          <%= date_input f, :deadline, value: @card.task.deadline, style: "width: 150px; margin-bottom: 0;" %>
                          <div class="zoom-out">
                            <%= error_tag f, :deadline %>
                            <%= error_tag f, :deadline_lt %>
                            <%= error_tag f, :deadline_before_dtstart %>
                          </div>
                        <% else %>
                          <%= Utilities.letters_date_format(@card.task.deadline) %>
                        <% end %>
                      </td>
                        <td data-label="Date de fin">
                          <%= if @is_contributor and @card.task.status_id == 4 do %>
                            <%= date_input f, :date_end, value: @card.task.date_end, style: "width: 150px; margin-bottom: 0;" %>
                            <%= error_tag f, :dt_end_lt_start %>
                          <% else %>
                              <%= if !is_nil(@card.task.date_end) do %>
                                <%= Utilities.letters_date_format(@card.task.date_end) %>
                              <% else %>
                                En attente
                              <% end %>
                          <% end %>
                        </td>
                        <td data-label="Durée estimée">
                          <%= if @is_admin or @is_attributor do %>
                            <%= number_input f, :estimated_duration, style: "width: 70px; margin-bottom: 0;", value: @card.task.estimated_duration %> h
                            <%= error_tag f, :negative_estimated %>
                          <% else %>
                            <%= @card.task.estimated_duration %> h
                          <% end %>
                        </td>
                        <td data-label="Durée effectuée">
                          <%= if @is_contributor do %>
                            <input id="task_performed_duration" name="task[performed_duration]" style="width: 70px; margin-bottom: 0;" type="number" value={@card.task.performed_duration} /> h
                            <%= error_tag f, :negative_performed%>
                          <% else %>
                            <%= @card.task.performed_duration %> h
                          <% end %>
                        </td>
                        <td data-label="Progression">
                          <b><%= number_input f, :progression, value: @card.task.progression, style: "width: 70px; margin-bottom: 0;" %> %</b>
                          <div class="zoom-out">
                            <%= error_tag f, :invalid_progression %>
                            <%= error_tag f, :progression_not_int %>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>

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
