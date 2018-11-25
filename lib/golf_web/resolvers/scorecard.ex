defmodule GolfWeb.Resolvers.Scorecard do

  def list_courses(_parent, _args, _resolution) do
    {:ok, Golf.Scorecard.list_courses()}
  end

  def find_hole(_parent, %{id: id}, _resolution) do
    {:ok, Golf.Scorecard.get_hole!(id)}
  end

  def holes_for_course(course, _, _) do
    query = Ecto.assoc(course, :holes)
    {:ok, Golf.Repo.all(query)}
  end

  def create_course(_parent, %{input: params}, _resolution) do
    case Golf.Scorecard.create_course(params) do
      {:error, changeset} ->
        {
          :error,
          message: "Couldn't create course",
          details: error_details(changeset)
        }
      {:ok, _} = success ->
        success
    end
  end

  def error_details(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end)
  end
end
