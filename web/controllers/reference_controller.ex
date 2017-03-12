defmodule Resume.ReferenceController do
  use Resume.Web, :controller

  alias Resume.Reference

  def new(conn, _params) do
    changeset = Reference.changeset(%Reference{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reference" => reference_params}) do
    changeset = 
      build_assoc(conn.assigns.current_user, :references)
      |> Reference.changeset(reference_params)

    case Repo.insert(changeset) do
      {:ok, _reference} ->
        conn
        |> put_flash(:info, "Reference created successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    reference = Repo.get!(Reference, id)
    changeset = Reference.changeset(reference)
    render(conn, "edit.html", reference: reference, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reference" => reference_params}) do
    reference = Repo.get!(Reference, id)
    changeset = Reference.changeset(reference, reference_params)

    case Repo.update(changeset) do
      {:ok, _reference} ->
        conn
        |> put_flash(:info, "Reference updated successfully.")
        |> redirect(to: registration_path(conn, :show))
      {:error, changeset} ->
        render(conn, "edit.html", reference: reference, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reference = Repo.get!(Reference, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reference)

    conn
    |> put_flash(:info, "Reference deleted successfully.")
    |> redirect(to: registration_path(conn, :show))
  end
end
