defmodule PmLogin.Email do
  import Swoosh.Email

  alias PmLogin.Mailer
  alias PmLogin.{Services, Utilities, Monitoring, Login}

  def send_state_of_client_request(send_to, request_id) do
    request = Services.get_clients_request!(request_id)

    state =
      cond do
        request.seen and not request.ongoing and not request.done and not request.finished ->
          "a été vue, le #{Utilities.simple_date_format_with_hours request.date_seen} par l'administrateur."

        request.seen and request.ongoing and not request.done and not request.finished ->
          type = if is_nil(request.task_id) and not is_nil(request.project_id), do: "Projet", else: "Tâche"

          case type do
            "Tâche" ->
              contributor_id = Monitoring.get_task!(request.task_id).contributor_id

              username = Login.get_username(contributor_id)

              "a été mise en traitement en tant que #{type},et sera traité(e) par #{username}."

            _ ->
              "a été mise en traitement en tant que #{type}."
          end

        request.seen and request.ongoing and request.done and not request.finished ->
          "a été accomplie, le #{Utilities.simple_date_format_with_hours request.date_done}."

        request.seen and request.ongoing and request.done and request.finished ->
          "a été cloturée, le #{Utilities.simple_date_format_with_hours request.date_finished}."

        true ->
          "n'a pas encore été vue"
      end

    date_ongoing =
      case request.date_ongoing do
        nil -> ""
        _ -> "Le #{Utilities.simple_date_format_with_hours request.date_ongoing}"
      end

    client = Services.get_active_client!(request.active_client_id)

    content = "
      <p> Bonjour #{client.user.username}, <br/> <p>
      <p> Votre demande ayant l'identifiant N°#{request.uuid}, #{state} <br /></p>
      <p> #{date_ongoing} </p>
    "

    new()
    |> from("monitoring@mgbi.mg")
    |> to(send_to)
    |> subject("[Requête N°#{request.uuid}]")
    |> html_body(content)
    |> Mailer.deliver()
  end
end
