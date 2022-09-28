# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PmLogin.Repo.insert!(%PmLogin.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias PmLogin.Repo

alias Ecto.UUID
import Ecto.Query, warn: false

alias PmLogin.Services
alias PmLogin.Services.{ClientsRequest, Type}


############# Fill the database with the data of the type table ##############
types = Repo.all(from t in Type)
if length(types) < 8 or Enum.empty?(types) do
  type =
    [
      %Type{
        id: 1,
        type: "moved"
      },

      %Type{
        id: 2,
        type: "archived"
      },

      %Type{
        id: 3,
        type: "deleted"
      },

      %Type{
        id: 4,
        type: "achieved"
      },

      %Type{
        id: 5,
        type: "created"
      },

      %Type{
        id: 6,
        type: "assigned"
      },

      %Type{
        id: 7,
        type: "updated"
      },

      %Type{
        id: 8,
        type: "requested"
      }
    ]

  for t <- type do
    Repo.insert!(t)
  end
end


############# Generate UUID for client request ##############
ids = Repo.all(
            from cr in ClientsRequest,
            where: is_nil(cr.uuid) or cr.uuid == "",
            select: cr.id
          )


##################
# Generate UUIDs #
##################
uuids =
  for _ <- 0..length(ids) - 1 do
    uuid = UUID.generate() |> String.split("-")

    Enum.join([Enum.at(uuid, 0), Enum.at(uuid, 1)])
  end


##########################################
# Set UUID for request who don't have it #
##########################################
for id <- ids, uuid <- uuids do
  client_request = Services.get_clients_request!(id)

  Services.update_clients_request(client_request, %{"uuid" => "REQ#{uuid}"})
end
