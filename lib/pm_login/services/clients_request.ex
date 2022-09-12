defmodule PmLogin.Services.ClientsRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias PmLogin.Services.ActiveClient
  alias PmLogin.Monitoring.Task
  alias PmLogin.Monitoring.Project

  schema "clients_requests" do
    field :title, :string
    field :content, :string
    field :date_post, :naive_datetime
    field :seen, :boolean
    field :ongoing, :boolean
    field :done, :boolean
    field :finished, :boolean
    field :file_urls, {:array, :string}, default: []
    # field :active_client_id, :id
    belongs_to :active_client, ActiveClient

    belongs_to :task, Task
    belongs_to :project, Project

    timestamps()
  end

  @doc false
  def changeset(clients_request, attrs) do
    clients_request
    |> cast(attrs, [:title ,:content, :date_post, :seen, :ongoing, :done, :finished, :active_client_id, :task_id, :project_id])
    # |> unique_constraint(:title, message: "Titre de requête déjà existant")
    # |> validate_required(:content, message: "Entrez le contenu de votre requête")
  end

  def create_changeset(clients_request, attrs) do
    clients_request
    |> cast(attrs, [:title ,:content, :date_post, :seen, :ongoing, :done, :finished, :active_client_id])
    |> foreign_key_constraint(:active_client_id)
    |> validate_required(:title, message: "Entrez l'intitulé de votre requête.")
    |> unique_constraint(:title, message: "Titre de requête déjà existant.")
    |> validate_required(:content, message: "Entrez le contenu de votre requête.")
    |> put_change(:date_post, NaiveDateTime.local_now)
    |> put_change(:seen, false)
    |> put_change(:ongoing, false)
    |> put_change(:done, false)
    |> put_change(:finished, false)
  end

  def upload_changeset(clients_request, attrs) do
    clients_request
    |> cast(attrs, [:file_urls])
  end
end
