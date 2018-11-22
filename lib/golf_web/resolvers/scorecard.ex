defmodule GolfWeb.Resolvers.Scorecard do

  def list_courses(_parent, _args, _resolution) do
    {:ok, Golf.Scorecard.list_courses()}
  end

end
