defmodule PmLogin.Email do
  import Swoosh.Email

  alias PmLogin.Mailer

  def bon_achat(user, request, state) do
    html_text = "
              <div style='display: flex; align-items: center; justify-content: center; background: blue; color: #fff'>
                <p>Bonjour, <p><br/>
                <p> Votre demande #{request} a été #{state} </p>
              </div>
                 "

    new()
    |> from("alainnambi@gmail.com")
    |> to(user)
    # |>cc(["matthieu@phidia.onmicrosoft.com", "mihaja@phidia.onmicrosoft.com", "focicom@gmail.com", "pp@phidia.onmicrosoft.com"])
    |> subject("[#{request}] #{state}")
    |> html_body(html_text)
    |> Mailer.deliver()
  end
end
