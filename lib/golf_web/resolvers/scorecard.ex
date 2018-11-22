defmodule GolfWeb.Resolvers.Scorecard do

  def list_courses(_parent, _args, _resolution) do
    {:ok, Golf.Scorecard.list_courses()}
  end

  def find_hole(_parent, %{id: id}, _resolution) do
    {:ok, Golf.Scorecard.get_hole!(id)}
  end
end
