defmodule Resume.Coherence.RegistrationController do
  @moduledoc """
  Handle account registration actions.

  Actions:

  * new - render the register form
  * create - create a new user account
  * edit - edit the user account
  * update - update the user account
  * delete - delete the user account
  """
  use Coherence.Web, :controller
  require Logger
  alias Coherence.ControllerHelpers, as: Helpers
  alias Resume.Repo
  alias Resume.Skill
  alias Resume.Experience
  alias Resume.Education
  alias Resume.Award

  plug Coherence.RequireLogin when action in ~w(show edit update delete)a
  plug Coherence.ValidateOption, :registerable
  plug :scrub_params, "registration" when action in [:create, :update]

  plug :layout_view
  plug :redirect_logged_in when action in [:new, :create]

  @doc false
  def layout_view(conn, _) do
    conn
    |> put_layout({Resume.LayoutView, "app.html"})
    |> put_view(Coherence.RegistrationView)
  end

  @doc """
  Render the new user form.
  """
  def new(conn, _params) do
    user_schema = Config.user_schema
    cs = Helpers.changeset(:registration, user_schema, user_schema.__struct__)
    conn
    |> render(:new, email: "", changeset: cs)
  end

  @doc """
  Create the new user account.

  Creates the new user account. Create and send a confirmation if
  this option is enabled.
  """
  def create(conn, %{"registration" => registration_params} = params) do
    user_schema = Config.user_schema
    cs = Helpers.changeset(:registration, user_schema, user_schema.__struct__, registration_params)
    case Config.repo.insert(cs) do
      {:ok, user} ->
        conn
        |> send_confirmation(user, user_schema)
        |> redirect_or_login(user, params, Config.allow_unconfirmed_access_for)
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  defp redirect_or_login(conn, _user, params, 0) do
    redirect_to(conn, :registration_create, params)
  end
  defp redirect_or_login(conn, user, params, _) do
    Helpers.login_user(conn, user, params)
  end

  @doc """
    Show the registration page.
    Modified to also show the skills belonging to the user
  """
  def show(conn, _) do
    user = Coherence.current_user(conn) |> preload_resume
    render(conn, "show.html", user: user)
  end

  @doc """
    Show the registered users
    View and route left unimplimented as there is no such thing as an administrator user
    Controller implimented for completeness
  """
  def index(conn, _) do
    users = User |> Repo.all |> preload_resume
    render(conn, "index.html", users: users)
  end

  @doc """
  Edit the registration.
  """
  def edit(conn, _) do
    user = Coherence.current_user(conn)
    changeset = Helpers.changeset(:registration, user.__struct__, user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  @doc """
  Update the registration.
  """
  def update(conn, %{"registration" => user_params} = params) do
    user_schema = Config.user_schema
    user = Coherence.current_user(conn)
    changeset = Helpers.changeset(:registration, user_schema, user, user_params)
    case Config.repo.update(changeset) do
      {:ok, user} ->
        apply(Config.auth_module, Config.update_login, [conn, user, [id_key: Config.schema_key]])
        |> put_flash(:info, "Account updated successfully.")
        |> redirect_to(:registration_update, params, user)
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  @doc """
  Delete a registration.
  """
  def delete(conn, params) do
    user = Coherence.current_user(conn)
    conn = Coherence.SessionController.delete(conn)
    Config.repo.delete! user
    redirect_to(conn, :registration_delete, params)
  end

  @doc """
  Preloads all the models the user owns
  """
  def preload_resume(users) do
    users
    |> Repo.preload(skills: from(s in Skill, order_by: s.name))
    |> Repo.preload(experiences: from(e in Experience, order_by: [desc: e.to]))
    |> Repo.preload(educations: from(e in Education, order_by: [desc: e.to]))
    |> Repo.preload(awards: from(e in Award, order_by: [desc: e.on]))
  end
end
