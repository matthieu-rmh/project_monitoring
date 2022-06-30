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
alias PmLogin.Services.Type

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
