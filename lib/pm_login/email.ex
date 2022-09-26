defmodule PmLogin.Email do
  import Swoosh.Email

  alias PmLogin.Mailer
  alias PmLogin.Services

  def send_state_of_client_request(send_to, request_id) do
    request = Services.get_clients_request!(request_id)

    state =
      cond do
        request.seen and not request.ongoing and not request.done and not request.finished ->
          "a été vue, le #{request.date_seen} par l'administrateur."

        request.seen and request.ongoing and not request.done and not request.finished ->
          "a été mise en traitement, le #{request.date_ongoing}."

        request.seen and request.ongoing and request.done and not request.finished ->
          "a été accomplie, le #{request.date_done}."

        request.seen and request.ongoing and request.done and request.finished ->
          "a été cloturée, le #{request.date_finished}."

        true ->
          "n'a pas encore été vue"
      end

    client = Services.get_active_client!(request.active_client_id)

    content = "
      <p> Bonjour #{client.user.username}, <br/> <p>
      <p> Votre demande nommée #{request.title} #{state} </p>
    "

    new()
    |> from("monitoring@mgbi.mg")
    |> to(send_to)
    |> subject("[Requête N°#{request.uuid}]")
    |> html_body(content)
    |> Mailer.deliver()
  end
end
