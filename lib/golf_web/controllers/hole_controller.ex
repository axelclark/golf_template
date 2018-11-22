defmodule GolfWeb.HoleController do
  use GolfWeb, :controller

  alias Golf.Scorecard
  alias Golf.Scorecard.Hole

  def index(conn, _params) do
    holes = Scorecard.list_holes()
    render(conn, "index.html", holes: holes)
  end

  def new(conn, _params) do
    changeset = Scorecard.change_hole(%Hole{})
    courses = Scorecard.list_courses()
    render(conn, "new.html", changeset: changeset, courses: courses)
  end

  def create(conn, %{"hole" => hole_params}) do
    case Scorecard.create_hole(hole_params) do
      {:ok, hole} ->
        conn
        |> put_flash(:info, "Hole created successfully.")
        |> redirect(to: Routes.hole_path(conn, :show, hole))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hole = Scorecard.get_hole!(id)
    render(conn, "show.html", hole: hole)
  end

  def edit(conn, %{"id" => id}) do
    hole = Scorecard.get_hole!(id)
    courses = Scorecard.list_courses()
    changeset = Scorecard.change_hole(hole)
    render(conn, "edit.html", hole: hole, changeset: changeset, courses: courses)
  end

  def update(conn, %{"id" => id, "hole" => hole_params}) do
    hole = Scorecard.get_hole!(id)

    case Scorecard.update_hole(hole, hole_params) do
      {:ok, hole} ->
        conn
        |> put_flash(:info, "Hole updated successfully.")
        |> redirect(to: Routes.hole_path(conn, :show, hole))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hole: hole, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hole = Scorecard.get_hole!(id)
    {:ok, _hole} = Scorecard.delete_hole(hole)

    conn
    |> put_flash(:info, "Hole deleted successfully.")
    |> redirect(to: Routes.hole_path(conn, :index))
  end
end
