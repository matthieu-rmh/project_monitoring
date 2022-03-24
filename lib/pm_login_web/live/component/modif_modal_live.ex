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
            <div class="modal-inner-card">
              <!-- Title -->
              <%= if @title != nil do %>
              <div class="modal-title" style="margin-bottom: 30px;">
                <%= @title %>
                <a href="#" style="position: relative; left: 30%;" title="Fermer" phx-click="left-button-click" phx-target={"#modal-#{@id}"}><i class="bi bi-x"></i></a>
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
                <!-- FIRST ROW -->
                  <div class="row">

                    <div class="column">
                      <div class="row">
                        <div class="column column-10">
                          <label>Nom: </label>
                          </div>
                          <div class="column column-65">
                          <%= text_input f, :title, [value: @card.name] %>
                          <%= error_tag f, :title %>
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
                        <div class="column column-35">
                          <img class="profile-pic-mini" src={Routes.static_path(@socket, "/#{@card.task.attributor.profile_picture}")} width="50"/>
                        </div>
                    </div>
                    </div>

                  </div>
                  <!-- END OF FIRST ROW -->

                    <!-- SECOND ROW -->
                      <div class="row">

                        <div class="column">

                              <%= label f, "Durée estimée (en heure):" %>
                              <%= if @is_admin or @is_attributor do %>
                                <b><%= number_input f, :estimated_duration, style: "width: 70px", value: @card.task.estimated_duration %> h</b>
                                <%= error_tag f, :negative_estimated %>
                              <% else %>
                                <b><%= @card.task.estimated_duration %></b>
                              <% end %>

                        </div>

                        <div class="column">
                          <label>Durée effectuée:</label>
                          <%= if @is_contributor do %>
                            <b><%= number_input f, :performed_duration, style: "width: 70px", value: @card.task.performed_duration %> h</b>
                            <%= error_tag f, :negative_performed%>
                          <% else %>
                            <b><%= @card.task.performed_duration %> h</b>
                          <% end %>
                        </div>


                      </div>
                      <!-- END OF SECOND ROW -->


                        <!-- THIRD ROW -->
                          <div class="row">

                            <div class="column">
                                <%= if @is_admin or @is_attributor do %>
                                  <%= label f, "Assigner contributeur" %>
                                  <%= select f, :contributor_id, @contributors, prompt: "Contributeurs:", selected: @card.task.contributor_id %>
                                  <%= error_tag f, :contributor_id %>
                                <% else %>
                                  <%= label f, "Contributeur" %>
                                    <%= if !is_nil(@card.task.contributor_id) do %>
                                      <%= @card.task.contributor.username %>
                                      <% else %>
                                      <%= "Pas d'intervenant" %>
                                    <% end %>
                                <% end %>
                            </div>

                            <div class="column">
                              <label>Priorité:</label>
                              <%= if @is_contributor and is_nil(@card.task.parent_id) do %>
                                <p><%= @card.task.priority.title %></p>
                              <% else %>
                                <%= select f, :priority_id, @priorities, value: @card.task.priority_id %>
                              <% end %>
                            </div>

                          </div>
                          <!-- END OF THIRD ROW -->



                  <!-- FOURTH ROW -->
                  <div class="row">
                    <div class="column">
                      <%= label f, "Date de début" %>
                      <%= if (@is_admin or @is_attributor)do %>
                        <%= date_input f, :date_start, value: @card.task.date_start %>
                      <% else %>
                        <p><%= Utilities.letters_date_format(@card.task.date_start) %></p>
                      <% end %>
                    </div>

                    <div class="column">
                      <%= label f, "Date de fin" %>
                      <%= if @is_contributor and @card.task.status_id == 4 do %>
                        <%= date_input f, :date_end, value: @card.task.date_end %>
                        <%= error_tag f, :dt_end_lt_start %>
                      <% else %>
                          <%= if !is_nil(@card.task.date_end) do %>
                            <p><%= Utilities.letters_date_format(@card.task.date_end) %></p>
                          <% else %>
                            <p>En attente</p>
                          <% end %>
                      <% end %>
                    </div>
                  </div>

                  <!-- END OF FOURTH ROW -->

                  <!-- FIFTH ROW -->
                    <div class="row" style="text-align:center;">
                      <div class="column">
                        <%= label f, "Progression: ", style: "margin-top: 5px;" %>
                        <b><%= number_input f, :progression, value: @card.task.progression, style: "width: 70px; margin-left: 20px;" %> %</b>
                        <%= error_tag f, :invalid_progression %>
                        <%= error_tag f, :progression_not_int %>
                      </div>

                      <div class="column">
                      <%= if (@is_admin or @is_attributor) do %>
                        <%= label f, "Date d'échéance" %>
                        <%= date_input f, :deadline, value: @card.task.deadline %>
                        <%= error_tag f, :deadline %>
                        <%= error_tag f, :deadline_lt %>
                        <%= error_tag f, :deadline_before_dtstart %>
                      <% end %>
                     </div>

                    </div>
                    <%= if @card.task.without_control and @is_contributor and @card.task.status_id != 5 do %>
                      <button type="button" class="btn btn-lg btn-success" phx-click="achieve" phx-value-id={@card.task.id}>Achever</button>
                    <% end %>
                  <!-- -->

                  <!-- Buttons -->
                  <div class="modal-buttons">
                    <!-- Left Button -->
                    <button class="btn btn-lg btn-default left-button"
                            type="button"
                            phx-click="left-button-click"
                            phx-target={"#modal-#{@id}"}>
                      <div>
                        <%= @left_button %>
                      </div>
                    </button>
                      <div class="">
                      <%= submit "Valider", class: "btn btn-lg btn-primary right-button" %>
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
