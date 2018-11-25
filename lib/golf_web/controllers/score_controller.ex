defmodule GolfWeb.ScoreController do
  use GolfWeb, :controller

  alias Golf.Scorecard
  alias Golf.Scorecard.Score

  def index(conn, _params) do
    scores = Scorecard.list_scores()
    render(conn, "index.html", scores: scores)
  end

  def new(conn, _params) do
    changeset = Scorecard.change_score(%Score{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"score" => score_params}) do
    case Scorecard.create_score(score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score created successfully.")
        |> redirect(to: Routes.score_path(conn, :show, score))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    score = Scorecard.get_score!(id)
    render(conn, "show.html", score: score)
  end

  def edit(conn, %{"id" => id}) do
    score = Scorecard.get_score!(id)
    changeset = Scorecard.change_score(score)
    render(conn, "edit.html", score: score, changeset: changeset)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = Scorecard.get_score!(id)

    case Scorecard.update_score(score, score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score updated successfully.")
        |> redirect(to: Routes.score_path(conn, :show, score))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", score: score, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = Scorecard.get_score!(id)
    {:ok, _score} = Scorecard.delete_score(score)

    conn
    |> put_flash(:info, "Score deleted successfully.")
    |> redirect(to: Routes.score_path(conn, :index))
  end
end
