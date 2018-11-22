defmodule GolfWeb.Schema.ScorecardTypes do
  use Absinthe.Schema.Notation

  @desc "A golf course"
  object :course do
    field :id, :id
    field :name, :string
    field :num_holes, :integer
  end
end
