defmodule PmLogin.Monitoring do
  @moduledoc """
  The Monitoring context.
  """
  import Ecto.Changeset
  import Ecto.Query, warn: false
  import PmLogin.Utilities
  alias PmLogin.Repo
  alias PmLogin.Kanban
  alias PmLogin.Monitoring.{Status, Task, Planified}
  alias PmLogin.Login
  alias PmLogin.Services
  alias PmLogin.Login.User
  alias PmLogin.Kanban.{Board, Stage, Card}

  @topic inspect(__MODULE__)
  def subscribe do
    Phoenix.PubSub.subscribe(PmLogin.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, @topic, {__MODULE__, event, result})
  end

  def hidden_subscribe do
    Phoenix.PubSub.subscribe(PmLogin.PubSub, "hidden_subscription")
  end

  defp broadcast_hidden_change(tuple, event) do
    Phoenix.PubSub.broadcast(PmLogin.PubSub, "hidden_subscription", {"hidden_subscription", event, tuple})
  end

  def filter_task_title(text, title) do
    Regex.match?(~r/^#{text}/i, title)
  end
  #DATE CALCULUS

  def avg_working_hours(%Task{} = t) do
    case working_days(t.date_start, t.deadline) do
      0 -> 0
      _ -> trunc(t.estimated_duration / working_days(t.date_start, t.deadline))
    end
  end

  def working_days(d1,d2) do
      Date.range(d1,Date.add(d2,-1))
      |> Enum.count(fn day -> is_working_day?(day) end)
  end

  def diff_between_dates do
    Date.diff(~D[2021-05-10], ~D[2021-05-04])
  end

  def is_working_day?(day) do
    Date.day_of_week(day) != 6 and Date.day_of_week(day) != 7
  end
  #checking user right in board

  def is_admin?(id) do
    user = Login.get_user!(id)
    user.right_id == 1
  end

  def is_attributor?(id) do
    user = Login.get_user!(id)
    user.right_id == 2
  end

  def is_contributor?(id) do
    user = Login.get_user!(id)
    user.right_id == 3
  end
  #Date validations and positive estimation with progression

  def del_contrib_id_if_nil(changeset) do
    contributor_id = get_field(changeset, :contributor_id)
    case contributor_id do
      nil -> changeset |> delete_change(:contributor_id)
      _ -> changeset
    end
  end

  def validate_progression(changeset) do
    progression  = get_field(changeset, :progression)
    case progression do
      nil -> changeset
      _ -> cond do
          progression < 0 or progression > 100 -> add_error(changeset, :invalid_progression, "Progression doit être comprise entre 0 et 100")
          not is_integer progression -> add_error(changeset, :progression_not_int, "Entrez un entier")
          true -> changeset
      end
    end
  end

  def validate_progression_mother(changeset) do
    progression  = get_field(changeset, :progression)
    case progression do
      nil -> changeset
      _ -> cond do
          progression < 0 -> put_change(changeset, :progression, 0)
          progression > 100 -> put_change(changeset, :progression, 100)
          # not is_integer progression -> add_error(changeset, :progression_not_int, "Entrez un entier")
          true -> changeset
      end
    end
  end

  def validate_positive_performed(changeset) do
      est = get_field(changeset, :performed_duration)
      case est do
        nil -> changeset
        _ -> cond do
        est < 0 -> changeset |> add_error(:negative_performed, "La durée exécutée ne peut être négative")
        true -> changeset
      end
    end
  end

  def validate_positive_estimated(changeset) do
      est = get_field(changeset, :estimated_duration)
      case est do
        nil -> changeset
        _ -> cond do
        est < 0 -> changeset |> add_error(:negative_estimated, "La durée estimée ne peut être négative")
        true -> changeset
      end
    end
  end

def validate_start_deadline(changeset) do
  date_start = get_field(changeset, :date_start)
  deadline = get_field(changeset, :deadline)

  if date_start != nil and deadline != nil do

    dt_start = date_start |> to_string |> string_to_date
    dt_deadline = deadline |> to_string |> string_to_date

    case Date.compare(dt_deadline, dt_start) do
      :lt ->
        changeset |> add_error(:deadline_before_dtstart, "La date d'échéance ne peut pas être antérieure à la date de début")
        _ -> changeset
      end

    else
      changeset
    end
  end

  def validate_start_end(changeset) do
    date_start = get_field(changeset, :date_start)
    date_end = get_field(changeset, :date_end)

    if date_start != nil and date_end != nil do

      dt_start = date_start |> to_string |> string_to_date
      dt_end = date_end |> to_string |> string_to_date

      case Date.compare(dt_end, dt_start) do
        :lt ->
          # IO.puts "startEnd"
          changeset |> add_error(:dt_end_lt_start, "La date finale ne peut pas être antérieure à la date de début")
          _ -> changeset
        end

      else
        changeset
      end
    end

    def validate_dates_without_deadline(changeset) do
      today = Date.utc_today
      date_start = get_field(changeset, :date_start)
      date_end = get_field(changeset, :date_end)

      if date_start != nil and date_end != nil do

        dt_start = date_start |> to_string |> string_to_date
        dt_end = date_end |> to_string |> string_to_date

        cond do
          Date.compare(dt_start,today) == :lt ->
            changeset
            |> add_error(:date_start_lt, "La date de début ne peut pas être antérieure à aujourd'hui")
          Date.compare(dt_end,today) == :lt ->
            changeset
            |> add_error(:date_end_lt, "La date de fin ne peut pas être antérieure à aujourd'hui")
          true -> changeset
        end

            else
              changeset
            end

    end

    def validate_dates_without_dtend(changeset) do
      today = Date.utc_today
      date_start = get_field(changeset, :date_start)
      deadline = get_field(changeset, :deadline)

      # IO.puts(date_start != "" and date_end != "" and deadline != "")
      if date_start != nil and deadline != nil do

        dt_start = date_start |> to_string |> string_to_date
        dt_deadline = deadline |> to_string |> string_to_date

        cond do
          Date.compare(dt_start,today) == :lt ->
            changeset
            |> add_error(:date_start_lt, "La date de début ne peut pas être antérieure à aujourd'hui")
          Date.compare(dt_deadline,today) == :lt ->
            changeset
            |> add_error(:deadline_lt, "La date d'échéance ne peut pas être antérieure à aujourd'hui")
          true -> changeset
        end
            else
              changeset
            end

    end

    def validate_dates(changeset) do
      today = Date.utc_today
      date_start = get_field(changeset, :date_start)
      date_end = get_field(changeset, :date_end)
      deadline = get_field(changeset, :deadline)

      # IO.puts(date_start != "" and date_end != "" and deadline != "")
      if date_start != nil and date_end != nil and deadline != nil do

        dt_start = date_start |> to_string |> string_to_date
        dt_end = date_end |> to_string |> string_to_date
        dt_deadline = deadline |> to_string |> string_to_date

        cond do
          Date.compare(dt_start,today) == :lt ->
            changeset
            |> add_error(:date_start_lt, "La date de début ne peut pas être antérieure à aujourd'hui")
            Date.compare(dt_end,today) == :lt ->
              changeset
              |> add_error(:date_end_lt, "La date de fin ne peut pas être antérieure à aujourd'hui")
              Date.compare(dt_deadline,today) == :lt ->
                changeset
                |> add_error(:deadline_lt, "La date d'échéance ne peut pas être antérieure à aujourd'hui")
                true -> changeset
              end
            else
              changeset
            end

    end

    def string_to_date(str) do
      [str_y, str_m, str_d] = String.split(str,"-")
      [y, m, d] = [String.to_integer(str_y), String.to_integer(str_m), String.to_integer(str_d)]
      {:ok, date} = Date.new(y,m,d)
      date
    end

  @doc """
  Returns the list of statuses.

  ## Examples

      iex> list_statuses()
      [%Status{}, ...]

  """
  def list_statuses do
    query = from s in Status,
            order_by: [asc: :id]
    Repo.all(query)
  end

  @doc """
  Gets a single status.

  Raises `Ecto.NoResultsError` if the Status does not exist.

  ## Examples

      iex> get_status!(123)
      %Status{}

      iex> get_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status!(id), do: Repo.get!(Status, id)

  @doc """
  Creates a status.

  ## Examples

      iex> create_status(%{field: value})
      {:ok, %Status{}}

      iex> create_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status(attrs \\ %{}) do
    %Status{}
    |> Status.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status.

  ## Examples

      iex> update_status(status, %{field: new_value})
      {:ok, %Status{}}

      iex> update_status(status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a status.

  ## Examples

      iex> delete_status(status)
      {:ok, %Status{}}

      iex> delete_status(status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status changes.

  ## Examples

      iex> change_status(status)
      %Ecto.Changeset{data: %Status{}}

  """
  def change_status(%Status{} = status, attrs \\ %{}) do
    Status.changeset(status, attrs)
  end

  #PLANIFIED

  def list_spawners do
    Supervisor.which_children(PmLogin.SpawnerSupervisor)
  end

  def list_spawners_states do
    for {_, pid, _, _} <- list_spawners() do
      :sys.get_state(pid)
    end
  end

  def list_spawners_pids do
    for {_, pid, _, _} <- list_spawners() do
      pid
    end
  end

  def get_planified_pid(planified_id) do
    pids = list_spawners_pids()
    Enum.find(pids, fn pid ->
      state_map = :sys.get_state(pid)
      planified_id == state_map[:planified].id
     end)
  end

  def terminate_spawner(planified_id) do
    pid = get_planified_pid(planified_id)
    DynamicSupervisor.terminate_child(PmLogin.SpawnerSupervisor, pid)
  end

  def change_planified(%Planified{} = planified, attrs \\ %{}) do
    Planified.changeset(planified, attrs)
  end

  def get_planified!(id) do
    query = from p in Planified,
            where: p.id == ^id
    Repo.one(query)
  end

  def delete_planified(%Planified{} = planified) do
    Repo.delete(planified)
  end

  def list_planified() do
    query = from p in Planified,
        order_by: [desc: :inserted_at]
    Repo.all(query)
  end

  def list_planified_by_project(project_id) do
    attributor_query = from u in User
    contributor_query = from us in User

    query = from p in Planified,
        preload: [attributor: ^attributor_query, contributor: ^contributor_query],
        order_by: [desc: :inserted_at],
        where: p.project_id == ^project_id
    Repo.all(query)
  end

  def create_planified(attrs \\ %{}) do
    %Planified{}
    |> Planified.create_changeset(attrs)
    |> Repo.insert()
  end

  def broadcast_planified({:ok, result}) do
    broadcast_change({:ok, result}, [:planified, :created])
  end

  def broadcast_planified_deletion({:ok, result}) do
    broadcast_change({:ok, result}, [:planified, :deleted])
  end

  alias PmLogin.Monitoring.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    query = from p in Project,
            order_by: [desc: :inserted_at]
    Repo.all(query)
  end

  def list_projects_by_contributor(con_id) do
    tasks_query = from t in Task,
                  where: t.contributor_id == ^con_id
    query = from p in Project,
            preload: [tasks: ^tasks_query],
            order_by: [desc: :inserted_at]
    Repo.all(query)
    |> Enum.filter(fn %PmLogin.Monitoring.Project{} = project ->
                                          project.tasks != [] end)
  end

  def add_progression_to_project(%Project{} = p) do
    primary_len = count_primaries(p)
    up_rate = (1/primary_len) * 100
    prog = p.progression + trunc(up_rate)
    update_project_progression(p, %{"progression" => prog})

    #round progression to 0 or 100
    project = get_project!(p.id)
    update_project_progression(project, %{"progression" => round_project_progression(p.id)})

  end

  def substract_progression_to_project(%Project{} = p) do
    primary_len = count_primaries(p)
    up_rate = (1/primary_len) * 100
    prog = p.progression - trunc(up_rate)
    update_project_progression(p, %{"progression" => prog})

    #round progression to 0 or 100
    project = get_project!(p.id)
    update_project_progression(project, %{"progression" => round_project_progression(p.id)})
  end

  def substract_project_progression_when_creating_primary(%Project{} = p) do
    primary_len = count_primaries(p) + 1
    IO.puts primary_len
    up_rate = case primary_len do
      0 -> 0
      _ -> (1/primary_len) * 100
    end

    prog = p.progression - (p.progression - trunc(up_rate))
    update_project_progression(p, %{"progression" => prog})

    #round progression to 0 or 100
    project = get_project!(p.id)
    update_project_progression(project, %{"progression" => round_project_progression(p.id)})
  end

  def get_task_mother!(id) do
    card_ch_query = from c in Card
    children_query = from ch in Task,
                    preload: [card: ^card_ch_query]
    query = from t in Task,
            where: t.id == ^id,
            preload: [children: ^children_query]
    Repo.one!(query)
  end

  def is_task_mother?(%Task{} = t) do
    task = get_task_mother!(t.id)
    length(task.children)>0
  end

  def achieve_children_tasks(%Task{} = t, curr_user_id) do
    task = get_task_mother!(t.id)
    for child <- task.children do

      stage_id = get_achieved_stage_id_from_project_id!(child.project_id)
      Kanban.put_childcard_to_achieve(child.card, %{"stage_id" => stage_id})
      update_task(child, %{"status_id" => 5})

    end
    update_task(task, %{"progression" => 100})
    Services.send_notifs_to_admins_and_attributors(curr_user_id, "La tâche #{task.title} a été achevée avec toutes ses tâches filles.")
  end

  def put_task_to_achieve(%Task{} = t, curr_user_id) do
    stage_id = get_achieved_stage_id_from_project_id!(t.project_id)

    task = get_task_with_card!(t.id)

    project = get_project_with_tasks!(t.project_id)

    Kanban.put_card_to_achieve(task.card, %{"stage_id" => stage_id})
    update_task(task, %{"status_id" => 5})

    if is_a_child?(task) do
      update_mother_task_progression(task, curr_user_id)
    end

    if is_task_primary?(task) do
      add_progression_to_project(project)
    end

    if is_task_mother?(task) do
      achieve_children_tasks(task, curr_user_id)
    end


    Services.send_notifs_to_admins_and_attributors(curr_user_id, "La tâche #{task.title} a été achevée.")
  end

  def is_task_primary?(%Task{} = t) do
    is_nil(t.parent_id)
  end

  def count_achieved_primaries(%Project{} = p) do
    (p.tasks) |> Enum.count(fn %Task{} = t ->
                            is_nil(t.parent_id) and t.status_id == 5
                            end)
  end

  def count_primaries(%Project{} = p) do
    (p.tasks) |> Enum.count(fn %Task{} = t -> is_nil(t.parent_id) end)
  end

  def update_project_progression(%Project{} = project, attrs) do
    project
    |> Project.update_progression_cs(attrs)
    |> Repo.update()
    |> broadcast_change([:project, :updated])
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  def get_project_with_tasks!(id) do
    tasks_query = from t in Task
    project_query = from p in Project,
                    preload: [tasks: ^tasks_query],
                    where: p.id == ^id
    Repo.one!(project_query)
  end

  def get_loading_stage_id_from_project_id!(id) do
    stages_query = from sta in Stage
    board_query = from b in Board,
                  preload: [stages: ^stages_query]
    query = from p in Project,
            where: p.id == ^id,
            preload: [board: ^board_query]
    stage = Repo.one!(query).board.stages
    |> Enum.find(fn(%Stage{} = s) -> s.status_id==4 end)
    stage.id
  end

  def get_achieved_stage_id_from_project_id!(id) do
    stages_query = from sta in Stage
    board_query = from b in Board,
                  preload: [stages: ^stages_query]
    query = from p in Project,
            where: p.id == ^id,
            preload: [board: ^board_query]
    stage = Repo.one!(query).board.stages
    |> Enum.find(fn(%Stage{} = s) -> s.status_id==5 end)
    stage.id
  end

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  alias PmLogin.Monitoring.Priority

  @doc """
  Returns the list of priorities.

  ## Examples

      iex> list_priorities()
      [%Priority{}, ...]

  """
  def list_priorities do
    Repo.all(Priority)
  end

  @doc """
  Gets a single priority.

  Raises `Ecto.NoResultsError` if the Priority does not exist.

  ## Examples

      iex> get_priority!(123)
      %Priority{}

      iex> get_priority!(456)
      ** (Ecto.NoResultsError)

  """
  def get_priority!(id), do: Repo.get!(Priority, id)

  @doc """
  Creates a priority.

  ## Examples

      iex> create_priority(%{field: value})
      {:ok, %Priority{}}

      iex> create_priority(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_priority(attrs \\ %{}) do
    %Priority{}
    |> Priority.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a priority.

  ## Examples

      iex> update_priority(priority, %{field: new_value})
      {:ok, %Priority{}}

      iex> update_priority(priority, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_priority(%Priority{} = priority, attrs) do
    priority
    |> Priority.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a priority.

  ## Examples

      iex> delete_priority(priority)
      {:ok, %Priority{}}

      iex> delete_priority(priority)
      {:error, %Ecto.Changeset{}}

  """
  def delete_priority(%Priority{} = priority) do
    Repo.delete(priority)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking priority changes.

  ## Examples

      iex> change_priority(priority)
      %Ecto.Changeset{data: %Priority{}}

  """
  def change_priority(%Priority{} = priority, attrs \\ %{}) do
    Priority.changeset(priority, attrs)
  end


  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_primary_tasks(project_id) do
    query = from t in Task,
            where: is_nil(t.parent_id) and t.project_id == ^project_id

    Repo.all(query)
  end

  def list_achieved_tasks_today do
    achieved_tasks = list_achieved_tasks
    curr_date = Services.current_date
    achieved_tasks
    |> Enum.filter(fn x ->
      (curr_date |> NaiveDateTime.to_date |> Date.day_of_era) == (x.achieved_at |> NaiveDateTime.to_date |> Date.day_of_era)
    end)

  end

  def list_achieved_tasks_this_week do
    achieved_tasks = list_achieved_tasks
    curr_date = Services.current_date
    achieved_tasks
    |> Enum.filter(fn x ->
      (curr_date |> NaiveDateTime.to_date |> Date.end_of_week) == (x.achieved_at |> NaiveDateTime.to_date |> Date.end_of_week)
    end)

  end

  def list_achieved_tasks_this_month do
    achieved_tasks = list_achieved_tasks
    curr_date = Services.current_date
    achieved_tasks
    |> Enum.filter(fn x ->
      (curr_date |> NaiveDateTime.to_date |> Date.end_of_month) == (x.achieved_at |> NaiveDateTime.to_date |> Date.end_of_month)
    end)

  end

  def naive_to_dt do
    Services.current_date
    |> NaiveDateTime.to_date
  end

  def list_achieved_tasks do
    attributor_query = from attr in User
    contributor_query = from contr in User
    project_query = from p in Project
    query = from t in Task,
            preload: [project: ^project_query, attributor: ^attributor_query, contributor: ^contributor_query],
            where: not is_nil(t.achieved_at) and is_nil(t.parent_id)

    Repo.all(query)
  end

  def list_tasks do
    Repo.all(Task)
  end

  def show_hidden_tasks(project_id) do
    query = from t in Task,
            where: t.hidden and t.project_id==^project_id
    Repo.update_all(query, set: [hidden: false])
    |> broadcast_hidden_change([:tasks, :shown])
  end

  def restore_archived_tasks(list_ids) do
    query = from t in Task,
            where: t.id in ^list_ids
    Repo.update_all(query, set: [hidden: false])
    |> broadcast_hidden_change([:tasks, :shown])
  end

  def list_hidden_tasks(project_id) do
    query = from t in Task,
            where: t.hidden and t.project_id==^project_id,
            preload: [contributor: ^from u in User]
    Repo.all(query)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  def get_task_with_card!(id) do
    card_query = from c in Card
    query = from t in Task,
            where: t.id == ^id,
            preload: [card: ^card_query]
    Repo.one!(query)
  end

  # def set_parent do
  #
  # end

  def get_task_with_parent!(id) do
    parent_card_query = from c in Card
    parent_query = from p in Task,
                    preload: [card: ^parent_card_query]
    card_query = from ca in Card
    query = from t in Task,
            where: t.id == ^id,
            preload: [parent: ^parent_query, card: ^card_query]
    Repo.one!(query)
  end

  def get_task_with_children!(id) do
    card_query = from c in Card
    query = from t in Task,
            where: t.id == ^id,
            preload: [children: :children, card: ^card_query]

    Repo.one!(query)
  end

  def is_a_child?(%Task{} = t) do
    !is_nil(t.parent_id)
  end

  def update_mother_task_progression(%Task{} = child, curr_user_id) do
    t = get_task_with_children!(child.parent_id)
    up_rate = (1/(length(t.children))) *100
    prog = t.progression + trunc(up_rate)
    update_mother_progression(t, %{"progression" => prog})

    #round progression to 0 or 100 if all children are achieved or none
    moth = get_task_with_children!(t.id)
    update_mother_progression(moth, %{"progression" => round_mother_progression(t.id)})

    rounded_moth = get_task_with_children!(t.id)
    # IO.inspect moth.project_id
    # IO.inspect moth.card
    # IO.inspect moth.card_id

    # IO.inspect moth.progression

    if rounded_moth.progression == 100 do
      stage_id = get_loading_stage_id_from_project_id!(moth.project_id)
      Kanban.put_mothercard_to_loading(moth.card, %{"stage_id" => stage_id})
      update_task(moth, %{"status_id" => 4})
      Services.send_notifs_to_admins_and_attributors(curr_user_id, "La tâche #{moth.title} a été placée automatiquement \"en cours\" car toutes ses tâches filles ont été achevées")
    end

  end

  def substract_mother_task_progression_when_removing_child_from_achieved(%Task{} = child) do
    t = get_task_with_children!(child.parent_id)
    down_rate = (1/(length(t.children))) *100
    prog = t.progression - trunc(down_rate)
    update_mother_progression(t, %{"progression" => prog})

    #round progression to 0 or 100 if all children are achieved or none
    moth = get_task_with_children!(t.id)
    update_mother_progression(moth, %{"progression" => round_mother_progression(t.id)})
  end

  def substract_mother_task_progression_when_creating_child(%Task{} = child) do
    t = get_task_with_children!(child.parent_id)
    nb_children = (length(t.children))
    down_rate = (1/nb_children) *100
    prog = t.progression - trunc(down_rate)
    update_mother_progression(t, %{"progression" => prog})

    #round progression to 0 or 100 if all children are achieved or none
    moth = get_task_with_children!(t.id)
    update_mother_progression(moth, %{"progression" => round_mother_progression(t.id)})

  end


  def get_task_with_status!(id) do
    status_query = from s in Status

    query = from t in Task,
            preload: [status: ^status_query],
            where: t.id == ^id

    Repo.one!(query)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end


  #REAL TASK CREATION WITH CARD

  def cards_list_primary_tasks(old_list) do
    old_list |> Enum.filter(fn card -> is_nil(card.task.parent_id) end)
  end

  def spawn_task(%Planified{} = planified) do

    planified_map = Map.from_struct(planified)
    now = NaiveDateTime.local_now()
    planned_deadline = NaiveDateTime.add(now, 3600 * planified_map[:estimated_duration])
                        |> NaiveDateTime.to_date()

    params = %{
      title: planified_map[:description],
      without_control: planified_map[:without_control],
      attributor_id: planified_map[:attributor_id],
      contributor_id: planified_map[:contributor_id],
      project_id: planified_map[:project_id],
      date_start: now |> NaiveDateTime.to_date(),
      estimated_duration: planified_map[:estimated_duration],
      deadline: planned_deadline
    }

    IO.inspect params

    {:ok, task} = create_real_task(params)

    current_project = get_project!(planified_map[:project_id])
    board = Kanban.get_board!(current_project.board_id)

    primary_stages = board.stages
    |> Enum.map(fn (%Kanban.Stage{} = stage) ->
      struct(stage, cards: cards_list_primary_tasks(stage.cards))
    end)

    primary_board = struct(board, stages: primary_stages)

    this_project = primary_board.project
    substract_project_progression_when_creating_primary(this_project)

    [head | _] = primary_board.stages
    Kanban.create_card(%{name: task.title, stage_id: head.id ,task_id: task.id})

    Services.send_notifs_to_admins_and_attributors(planified_map[:attributor_id], "Tâche nouvellement créee du nom de #{task.title} par #{Login.get_user!(planified_map[:attributor_id]).username} dans le projet #{this_project.title}.")

    if not is_nil(planified_map[:contributor_id]) do
      Services.send_notif_to_one(planified_map[:attributor_id], planified_map[:contributor_id],"#{Login.get_user!(planified_map[:attributor_id]).username} vous a assigné à la tâche #{task.title} dans le projet #{this_project.title}.")
    end

  end

  def create_real_task(attrs \\ %{}) do
    %Task{}
    |> Task.real_creation_changeset(attrs)
    |> Repo.insert()
  end
  #

  def create_task_with_card(attrs \\ %{}) do
    %Task{}
    |> Task.create_changeset(attrs)
    |> Repo.insert()
  end

  def create_secondary_task(attrs \\ %{}) do
    %Task{}
    |> Task.secondary_changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.update_changeset(attrs)
    |> Repo.update()
  end

  def hide_task(%Task{} = task) do
    task
    |> Task.hidden_changeset(%{"hidden" => true})
    |> Repo.update()
    |> broadcast_hidden_change([:task, :hidden])
  end

  def round_project_progression(id) do
    project = get_project_with_tasks!(id)
    len = count_primaries(project)
    achieved = count_achieved_primaries(project)

    case achieved do
      ^len -> 100
      0 -> 0
      _ -> project.progression
    end
  end

  def round_mother_progression(id) do
    task = get_task_with_children!(id)
    len = length(task.children)

    achieved = count_achieved_children_tasks(task)

      case achieved do
        ^len -> 100
        0 -> 0
        _ -> task.progression
      end
  end


  def count_achieved_children_tasks(%Task{} = mother) do
    (mother.children) |> Enum.count(fn %Task{} = t -> t.status_id == 5 end)
  end

  def update_mother_progression(%Task{} = task, attrs) do
    task
    |> Task.update_moth_prg_changeset(attrs)
    |> Repo.update()
    |> broadcast_change([:mother, :updated])
  end

  def update_task_status(%Task{} = task, attrs) do
    task
    |> Task.update_status_changeset(attrs)
    |> Repo.update()

  end

  def broadcast_status_change(tuple) do
    tuple
    |> broadcast_change([:status, :updated])
  end

  def broadcast_updated_task(tuple),do: tuple |> broadcast_change([:task, :updated])





  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  alias PmLogin.Monitoring.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  def list_comments_by_task_id(task_id) do
    query = from c in Comment,
            where: c.task_id == ^task_id,
            order_by: [asc: :inserted_at]

    Repo.all(query)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def post_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.create_changeset(attrs)
    |> Repo.insert()
    # |> broadcast_change([:comment, :posted])
  end

  def broadcast_com(tuple) do
    broadcast_change(tuple ,[:comment, :posted])
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def update_comment_files(%Comment{} = comment, attrs) do
    comment
    |> Comment.upload_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  def list_project_contributors(%Board{} = board) do
    contributor_ids = board.project.tasks
          |> Enum.filter(fn task -> (not is_nil(task.contributor_id)) end)
          |> Enum.map(fn task -> task.contributor_id end)
          |> Enum.uniq

    for id <- contributor_ids do
      Login.get_user!(id)
    end
  end

  def list_project_attributors(%Board{} = board) do
    attributors_ids = board.project.tasks
          |> Enum.filter(fn task -> (not is_nil(task.attributor_id)) end)
          |> Enum.map(fn task -> task.attributor_id end)
          |> Enum.uniq

    for id <- attributors_ids do
      Login.get_user!(id)
    end
  end

  def list_my_unachieved_tasks(my_id) do
    project_query = from p in Project
    query = from t in Task,
            preload: [project: ^project_query],
            where: t.contributor_id == ^my_id and is_nil(t.achieved_at)

    Repo.all(query)
  end

  def list_my_achieved_tasks(my_id) do
    query = from t in Task,
            where: t.contributor_id == ^my_id and not is_nil(t.achieved_at) and is_nil(t.parent_id)

    Repo.all(query)
  end

  def my_onboard_achieved(my_id) do
    project_query = from p in Project
    attributor_query = from u in User
    query = from t in Task,
            where: t.contributor_id == ^my_id and not is_nil(t.achieved_at) and is_nil(t.parent_id),
            order_by: [desc: :achieved_at],
            preload: [project: ^project_query, attributor: ^attributor_query]

    Repo.all(query)
  end


  def duration_diff(%Task{} = t) do
    cond do
      t.performed_duration > t.estimated_duration -> "(+ #{t.performed_duration-t.estimated_duration} h)"
      t.performed_duration == t.estimated_duration -> "(= #{t.performed_duration-t.estimated_duration} h)"
      t.performed_duration < t.estimated_duration -> "(- #{t.estimated_duration - t.performed_duration} h)"
    end
  end

  def duration_diff_color_class(%Task{} = t) do
    cond do
      t.performed_duration > t.estimated_duration -> "durr__diff__gt"
      t.performed_duration == t.estimated_duration -> "durr__diff__eq"
      t.performed_duration < t.estimated_duration -> "durr__diff__lt"
    end
  end

  def date_diff(%Task{} = t) do
    cond do
      Date.diff(t.achieved_at, t.deadline) > 0 -> "#{Date.diff(t.achieved_at, t.deadline)} jours de retard"
      Date.diff(t.achieved_at, t.deadline) == 0 -> "Achevée le jour même"
      Date.diff(t.achieved_at, t.deadline) < 0 -> "#{Date.diff(t.deadline, t.achieved_at)} jours d'avance"
    end
  end

  def date_diff_color_class(%Task{} = t) do
    cond do
      Date.diff(t.achieved_at, t.deadline) > 0 -> "dt_durr__diff__gt"
      Date.diff(t.achieved_at, t.deadline) == 0 -> "dt_durr__diff__eq"
      Date.diff(t.achieved_at, t.deadline) < 0 -> "dt_durr__diff__lt"
    end
  end

  def my_achieved_length(my_id) do
      list_my_achieved_tasks(my_id)
      |> length
  end

  def my_unachieved_length(my_id) do
    list_my_unachieved_tasks(my_id)
    |> length
  end


  def list_my_near_unachieved_tasks(my_id) do
    today = NaiveDateTime.local_now |> NaiveDateTime.to_date
    range = 0..7
    tasks = list_my_unachieved_tasks(my_id)
    tasks |> Enum.filter(fn task -> Date.diff(task.deadline, today) in range end)
  end

  def list_my_past_unachieved_tasks(my_id) do
    today = NaiveDateTime.local_now |> NaiveDateTime.to_date
    tasks = list_my_unachieved_tasks(my_id)
    tasks |> Enum.filter(fn task -> Date.diff(task.deadline, today) < 0 end)
  end

  def warning_text(task) do
    today = NaiveDateTime.local_now |> NaiveDateTime.to_date
    cond do
      Date.diff(task.deadline, today) == 7 -> "dans une semaine"
      Date.diff(task.deadline, today) in 2..6 -> "dans #{Date.diff(task.deadline, today)} jours"
      Date.diff(task.deadline, today) == 1 -> "demain"
      Date.diff(task.deadline, today) == 0 -> "aujourd'hui"
      true -> ""
    end
  end

  def list_last_seven_days(my_id) do
    achieved = list_my_achieved_tasks(my_id)
    today = NaiveDateTime.local_now
    |> NaiveDateTime.to_date
    Enum.map(1..7, fn x -> Date.add(today, -x) end)
    |> Enum.map(fn date ->
        [date, Enum.count(achieved, fn task -> Date.compare(date, task.achieved_at) == :eq end)]
    end)
    |> Enum.map(fn [date, number] -> [simple_date_format(date), number]  end)
    |> Enum.reverse
  end


  # def achieved_number_by_day(list) do

  # end


end
