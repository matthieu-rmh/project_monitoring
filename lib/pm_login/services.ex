defmodule PmLogin.Services do
  @moduledoc """
  The Services context.
  """

  import Ecto.Query, warn: false
  alias PmLogin.Repo

  alias PmLogin.Services.Company
  alias PmLogin.Login.User
  alias PmLogin.Login
  alias PmLogin.Services.{Software, Editor, License, AssistContract}

  @topic inspect(__MODULE__)
  def subscribe do
    Phoenix.PubSub.subscribe(PmLogin.PubSub, @topic)
  end

  def subscribe_to_request_topic do
    Phoenix.PubSub.subscribe(PmLogin.PubSub, "request_topic")
  end

  def broadcast_request_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, "request_topic", {"request_topic", event, result})
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, @topic, {__MODULE__, event, result})
  end

  defp broadcast_notifs({nbs, nil}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, @topic, {__MODULE__, event, nbs})
  end

  defp broadcast_notif({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, @topic, {__MODULE__, event, result})
  end

  defp broadcast_contract_deleted({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, @topic, {__MODULE__, event, result})
  end


  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end


  @doc """
  Returns the list of softwares.

  ## Examples

      iex> list_softwares()
      [%Software{}, ...]

  """
  def list_softwares do
    Repo.all(Software)
  end

  def list_softwares_with_company do
    company_query = from c in Company
    query = from sw in Software,
            preload: [company: ^company_query]
    Repo.all(query)
  end
  @doc """
  Gets a single software.

  Raises `Ecto.NoResultsError` if the Software does not exist.

  ## Examples

      iex> get_software!(123)
      %Software{}

      iex> get_software!(456)
      ** (Ecto.NoResultsError)

  """
  def get_software!(id), do: Repo.get!(Software, id)

  def get_software_with_company!(id) do
    company_query = from c in Company
    query = from sw in Software,
            where: sw.id == ^id,
            preload: [company: ^company_query]
    Repo.one!(query)
  end
  @doc """
  Creates a software.

  ## Examples

      iex> create_software(%{field: value})
      {:ok, %Software{}}

      iex> create_software(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_software(attrs \\ %{}) do
    %Software{}
    |> Software.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a software.

  ## Examples

      iex> update_software(software, %{field: new_value})
      {:ok, %Software{}}

      iex> update_software(software, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_software(%Software{} = software, attrs) do
    software
    |> Software.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a software.

  ## Examples

      iex> delete_software(software)
      {:ok, %Software{}}

      iex> delete_software(software)
      {:error, %Ecto.Changeset{}}

  """
  def delete_software(%Software{} = software) do
    Repo.delete(software)
    |> broadcast_change([:software,:deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking software changes.

  ## Examples

      iex> change_software(software)
      %Ecto.Changeset{data: %Software{}}

  """
  def change_software(%Software{} = software, attrs \\ %{}) do
    Software.changeset(software, attrs)
  end


  @doc """
  Returns the list of editors.

  ## Examples

      iex> list_editors()
      [%Editor{}, ...]

  """
  def list_editors do
    Repo.all(Editor)
  end

  def list_all_editors do
    company_query = from c in Company
    query = from e in Editor,
            preload: [company: ^company_query]
    Repo.all(query)
  end

  @doc """
  Gets a single editor.

  Raises `Ecto.NoResultsError` if the Editor does not exist.

  ## Examples

      iex> get_editor!(123)
      %Editor{}

      iex> get_editor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_editor!(id), do: Repo.get!(Editor, id)

  def get_editor_with_company!(id) do
    company_query = from c in Company
    query = from e in Editor,
            where: e.id == ^id,
            preload: [company: ^company_query]
    Repo.one!(query)
  end
  @doc """
  Creates a editor.

  ## Examples

      iex> create_editor(%{field: value})
      {:ok, %Editor{}}

      iex> create_editor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_editor(attrs \\ %{}) do
    %Editor{}
    |> Editor.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a editor.

  ## Examples

      iex> update_editor(editor, %{field: new_value})
      {:ok, %Editor{}}

      iex> update_editor(editor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_editor(%Editor{} = editor, attrs) do
    editor
    |> Editor.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a editor.

  ## Examples

      iex> delete_editor(editor)
      {:ok, %Editor{}}

      iex> delete_editor(editor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_editor(%Editor{} = editor) do
    Repo.delete(editor)
    |> broadcast_change([:editor, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking editor changes.

  ## Examples

      iex> change_editor(editor)
      %Ecto.Changeset{data: %Editor{}}

  """
  def change_editor(%Editor{} = editor, attrs \\ %{}) do
    Editor.changeset(editor, attrs)
  end


  @doc """
  Returns the list of licenses.

  ## Examples

      iex> list_licenses()
      [%License{}, ...]

  """
  def list_licenses do
    Repo.all(License)
  end

  def list_licenses_with_company do
    company_query = from c in Company
    query = from l in License,
            preload: [company: ^company_query]
    Repo.all(query)
  end

  @doc """
  Gets a single license.

  Raises `Ecto.NoResultsError` if the License does not exist.

  ## Examples

      iex> get_license!(123)
      %License{}

      iex> get_license!(456)
      ** (Ecto.NoResultsError)

  """
  def get_license!(id), do: Repo.get!(License, id)

  def get_license_with_company!(id) do
    company_query = from c in Company
    query = from l in License,
            where: l.id == ^id,
            preload: [company: ^company_query]
    Repo.one!(query)
  end
  @doc """
  Creates a license.

  ## Examples

      iex> create_license(%{field: value})
      {:ok, %License{}}

      iex> create_license(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_license(attrs \\ %{}) do
    %License{}
    |> License.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a license.

  ## Examples

      iex> update_license(license, %{field: new_value})
      {:ok, %License{}}

      iex> update_license(license, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_license(%License{} = license, attrs) do
    license
    |> License.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a license.

  ## Examples

      iex> delete_license(license)
      {:ok, %License{}}

      iex> delete_license(license)
      {:error, %Ecto.Changeset{}}

  """
  def delete_license(%License{} = license) do
    Repo.delete(license)
    |> broadcast_change([:license,:deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking license changes.

  ## Examples

      iex> change_license(license)
      %Ecto.Changeset{data: %License{}}

  """
  def change_license(%License{} = license, attrs \\ %{}) do
    License.changeset(license, attrs)
  end


  @doc """
  Returns the list of assist_contracts.

  ## Examples

      iex> list_assist_contracts()
      [%AssistContract{}, ...]

  """
  def list_assist_contracts do
    Repo.all(AssistContract)
  end

  def list_contracts do
    company_query = from c in Company
    query = from ac in AssistContract,
            preload: [company: ^company_query]
    Repo.all(query)
  end

  @doc """
  Gets a single assist_contract.

  Raises `Ecto.NoResultsError` if the Assist contract does not exist.

  ## Examples

      iex> get_assist_contract!(123)
      %AssistContract{}

      iex> get_assist_contract!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assist_contract!(id), do: Repo.get!(AssistContract, id)

  def get_contract!(id) do
    company_query = from c in Company
    query = from ac in AssistContract,
            where: ac.id == ^id,
            preload: [company: ^company_query]
    Repo.one!(query)
  end
  @doc """
  Creates a assist_contract.

  ## Examples

      iex> create_assist_contract(%{field: value})
      {:ok, %AssistContract{}}

      iex> create_assist_contract(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assist_contract(attrs \\ %{}) do
    %AssistContract{}
    |> AssistContract.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assist_contract.

  ## Examples

      iex> update_assist_contract(assist_contract, %{field: new_value})
      {:ok, %AssistContract{}}

      iex> update_assist_contract(assist_contract, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assist_contract(%AssistContract{} = assist_contract, attrs) do
    assist_contract
    |> AssistContract.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a assist_contract.

  ## Examples

      iex> delete_assist_contract(assist_contract)
      {:ok, %AssistContract{}}

      iex> delete_assist_contract(assist_contract)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assist_contract(%AssistContract{} = assist_contract) do
    Repo.delete(assist_contract)
    |> broadcast_contract_deleted([:contract,:deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assist_contract changes.

  ## Examples

      iex> change_assist_contract(assist_contract)
      %Ecto.Changeset{data: %AssistContract{}}

  """
  def change_assist_contract(%AssistContract{} = assist_contract, attrs \\ %{}) do
    AssistContract.changeset(assist_contract, attrs)
  end

  alias PmLogin.Services.ActiveClient

  @doc """
  Returns the list of active_clients.

  ## Examples

      iex> list_active_clients()
      [%ActiveClient{}, ...]

  """
  def list_active_clients do
    company_query = from c in Company
    user_query = from u in User
    query = from ac in ActiveClient,
            preload: [user: ^user_query, company: ^company_query]
    Repo.all(query)
    # Repo.all(ActiveClient)
  end

  @doc """
  Gets a single active_client.

  Raises `Ecto.NoResultsError` if the Active client does not exist.

  ## Examples

      iex> get_active_client!(123)
      %ActiveClient{}

      iex> get_active_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_active_client!(id) do
    # |> Repo.preload(User)
    # |> Repo.get!(id)

    query = from ac in ActiveClient,
          preload: [user: ^from u in User],
          where: ac.id == ^id
    Repo.one!(query)

  end

  def get_active_client_from_userid!(user_id) do
    # |> Repo.preload(User)
    # |> Repo.get!(id)
    editor_query = from e in Editor
    ac_query = from assc in AssistContract
    li_query = from li in License
    software_query = from e in Software

    company_query = from c in Company,
                    preload: [editors: ^editor_query,assist_contracts: ^ac_query,licenses: ^li_query,softwares: ^software_query]
    user_query = from u in User

    query = from ac in ActiveClient,
          preload: [user: ^user_query, company: ^company_query],
          where: ac.user_id == ^user_id
    Repo.one!(query)

  end

  def get_ac_id_from_user_id(user_id) do
    query = from ac in ActiveClient,
            where: ac.user_id == ^user_id
    Repo.one!(query).id
  end
  @doc """
  Creates a active_client.

  ## Examples

      iex> create_active_client(%{field: value})
      {:ok, %ActiveClient{}}

      iex> create_active_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_active_client(attrs \\ %{}) do
    %ActiveClient{}
    |> ActiveClient.changeset(attrs)
    |> Repo.insert()
    |> broadcast_change([:active_client, :created])
  end

  # def create_active_client_func(attrs \\ %{}) do
  #   %ActiveClient{}
  #   |> ActiveClient.create_changeset(attrs)
  #   |> Repo.insert()
  # end

  @doc """
  Updates a active_client.

  ## Examples

      iex> update_active_client(active_client, %{field: new_value})
      {:ok, %ActiveClient{}}

      iex> update_active_client(active_client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_active_client(%ActiveClient{} = active_client, attrs) do
    active_client
    |> ActiveClient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a active_client.

  ## Examples

      iex> delete_active_client(active_client)
      {:ok, %ActiveClient{}}

      iex> delete_active_client(active_client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_active_client(%ActiveClient{} = active_client) do
    Repo.delete(active_client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking active_client changes.

  ## Examples

      iex> change_active_client(active_client)
      %Ecto.Changeset{data: %ActiveClient{}}

  """
  def change_active_client(%ActiveClient{} = active_client, attrs \\ %{}) do
    ActiveClient.changeset(active_client, attrs)
  end



  alias PmLogin.Services.ClientsRequest

  @doc """
  Returns the list of clients_requests.

  ## Examples

      iex> list_clients_requests()
      [%ClientsRequest{}, ...]

  """
  def list_clients_requests do
    Repo.all(ClientsRequest)
  end

  def list_my_requests(user_id) do
    company_query = from c in Company
    user_query = from u in User
    ac_query = from ac in ActiveClient,
            preload: [user: ^user_query, company: ^company_query]
    query = from req in ClientsRequest,
            preload: [active_client: ^ac_query],
            where: req.active_client_id == ^get_ac_id_from_user_id(user_id),
            order_by: [desc: req.date_post]
    Repo.all(query)

  end

  def list_requests do
    company_query = from c in Company
    user_query = from u in User
    ac_query = from ac in ActiveClient,
            preload: [user: ^user_query, company: ^company_query]
    query = from req in ClientsRequest,
            preload: [active_client: ^ac_query],
            order_by: [desc: req.date_post]
    Repo.all(query)
  end
  # def function_name do
  #
  # end

  @doc """
  Gets a single clients_request.

  Raises `Ecto.NoResultsError` if the Clients request does not exist.

  ## Examples

      iex> get_clients_request!(123)
      %ClientsRequest{}

      iex> get_clients_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clients_request!(id), do: Repo.get!(ClientsRequest, id)

  def get_request_with_user_id!(id) do
    ac_request = from ac in ActiveClient
    query = from req in ClientsRequest,
            preload: [active_client: ^ac_request],
            where: req.id == ^id
    Repo.one!(query)
  end

  @doc """
  Creates a clients_request.

  ## Examples

      iex> create_clients_request(%{field: value})
      {:ok, %ClientsRequest{}}

      iex> create_clients_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clients_request(attrs \\ %{}) do
    %ClientsRequest{}
    |> ClientsRequest.create_changeset(attrs)
    |> Repo.insert()
  end

  def broadcast_request(tuple) do
    broadcast_request_change(tuple, [:request , :sent])
  end

  @doc """
  Updates a clients_request.

  ## Examples

      iex> update_clients_request(clients_request, %{field: new_value})
      {:ok, %ClientsRequest{}}

      iex> update_clients_request(clients_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clients_request(%ClientsRequest{} = clients_request, attrs) do
    clients_request
    |> ClientsRequest.changeset(attrs)
    |> Repo.update()
  end

  def update_request_bool(%ClientsRequest{} = clients_request, attrs) do
    clients_request
    |> ClientsRequest.changeset(attrs)
    |> Repo.update()
    |> broadcast_request_update
  end

  def update_request_files(%ClientsRequest{} = clients_request, attrs) do
    clients_request
    |> ClientsRequest.upload_changeset(attrs)
    |> Repo.update()
    |> broadcast_request_update
  end

  def broadcast_request_update(tuple) do
    broadcast_request_change(tuple, [:request, :updated])
  end

  @doc """
  Deletes a clients_request.

  ## Examples

      iex> delete_clients_request(clients_request)
      {:ok, %ClientsRequest{}}

      iex> delete_clients_request(clients_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clients_request(%ClientsRequest{} = clients_request) do
    Repo.delete(clients_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clients_request changes.

  ## Examples

      iex> change_clients_request(clients_request)
      %Ecto.Changeset{data: %ClientsRequest{}}

  """
  def change_clients_request(%ClientsRequest{} = clients_request, attrs \\ %{}) do
    ClientsRequest.changeset(clients_request, attrs)
  end

  alias PmLogin.Services.Notification

  @doc """
  Returns the list of notifications.

  ## Examples

      iex> list_notifications()
      [%Notification{}, ...]

  """
  def list_notifications do
    Repo.all(Notification)
  end

  def list_my_notifications(id) do
    query = from n in Notification,
            where: n.receiver_id == ^id,
            order_by: [desc: n.inserted_at]
    Repo.all(query)
  end

  def list_my_notifications_with_limit(id, limit) do
    query = from n in Notification,
            where: n.receiver_id == ^id,
            order_by: [desc: n.inserted_at],
            limit: ^limit
    Repo.all(query)
  end

  def list_my_unseen_notifications(id) do
    query = from n in Notification,
            where: n.receiver_id == ^id and not n.seen,
            order_by: n.inserted_at
    Repo.all(query)
  end

  def time_ago(%Notification{} = n) do
    seconds_ago = NaiveDateTime.diff(NaiveDateTime.utc_now, n.inserted_at)
    # IO.puts seconds_ago
    cond do
      seconds_ago > 59 and seconds_ago < 3600 -> "#{trunc(seconds_ago / 60)} minute(s)"
      seconds_ago > 3599 and seconds_ago < 86400 -> "#{trunc(seconds_ago / 3600)} heure(s)"
      seconds_ago > 86399 and seconds_ago < 2592000 -> "#{trunc(seconds_ago / 86400)} jour(s)"
      seconds_ago > 2591999 and seconds_ago < 31104000 -> "#{trunc(seconds_ago / 2592000)} mois"
      seconds_ago > 31103999 -> "#{trunc(seconds_ago / 31104000)} an(s)"
      true -> "#{seconds_ago} secondes"
    end
  end

  @doc """
  Gets a single notification.

  Raises `Ecto.NoResultsError` if the Notification does not exist.

  ## Examples

      iex> get_notification!(123)
      %Notification{}

      iex> get_notification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notification!(id), do: Repo.get!(Notification, id)

  @doc """
  Creates a notification.

  ## Examples

      iex> create_notification(%{field: value})
      {:ok, %Notification{}}

      iex> create_notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def put_seen_some_notifs(ids) do
    query = from n in Notification,
            where: n.id in ^ids
    Repo.update_all(query, set: [seen: true])
  end

  def create_notification(attrs \\ %{}) do
    %Notification{}
    |> Notification.changeset(attrs)
    |> Repo.insert()
  end

  def send_notif_to_one(sender_id, receiver_id, content) do
  %{"content" => content, "seen" => false, "sender_id" => sender_id, "receiver_id" => receiver_id}
  |> send_notification
  end

  def send_notifs_to_admins_and_attributors(curr_user_id, content) do
    notifs = Login.list_admins_and_attributors(curr_user_id)
    |> Enum.map(fn id ->
       [sender_id: curr_user_id, content: content,
       receiver_id: id, seen: false,
       inserted_at: (NaiveDateTime.utc_now)|>NaiveDateTime.truncate(:second),
       updated_at: (NaiveDateTime.utc_now)|>NaiveDateTime.truncate(:second)]
     end)

    Repo.insert_all(Notification, notifs)
    |> broadcast_notifs([:notifs, :sent])
  end

  def send_notifs_to_admins(curr_user_id, content) do
    notifs = Login.list_admins(curr_user_id)
    |> Enum.map(fn id ->
       [sender_id: curr_user_id, content: content,
       receiver_id: id, seen: false,
       inserted_at: (NaiveDateTime.utc_now)|>NaiveDateTime.truncate(:second),
       updated_at: (NaiveDateTime.utc_now)|>NaiveDateTime.truncate(:second)]
     end)

    Repo.insert_all(Notification, notifs)
    |> broadcast_notifs([:notifs, :sent])
  end



  def send_notification(attrs \\ %{}) do
    %Notification{}
    |> Notification.create_changeset(attrs)
    |> Repo.insert()
    |> broadcast_notif([:notifs, :sent])
  end

  @doc """
  Updates a notification.

  ## Examples

      iex> update_notification(notification, %{field: new_value})
      {:ok, %Notification{}}

      iex> update_notification(notification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notification(%Notification{} = notification, attrs) do
    notification
    |> Notification.changeset(attrs)
    |> Repo.update()
  end

  def put_seen_notification(%Notification{} = notification, attrs \\ %{}) do
    notification
    |> Notification.seen_changeset(attrs)
    |> Repo.update()
  end

  #SEEN NOTIF TO FALSE
  def put_unseen_notification(%Notification{} = notification, attrs \\ %{}) do
    notification
    |> Notification.unseen_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a notification.

  ## Examples

      iex> delete_notification(notification)
      {:ok, %Notification{}}

      iex> delete_notification(notification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notification(%Notification{} = notification) do
    Repo.delete(notification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notification changes.

  ## Examples

      iex> change_notification(notification)
      %Ecto.Changeset{data: %Notification{}}

  """
  def change_notification(%Notification{} = notification, attrs \\ %{}) do
    Notification.changeset(notification, attrs)
  end

  def current_date do
    {:ok, date} = :calendar.universal_time
    |> :calendar.universal_time_to_local_time
    |> NaiveDateTime.from_erl
    date
  end
end
