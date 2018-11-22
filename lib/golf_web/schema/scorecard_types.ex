defmodule GolfWeb.Schema.ScorecardTypes do
  use Absinthe.Schema.Notation

  @desc "A golf course"
  object :course do
    field :id, :id
    field :name, :string
    field :holes, :integer
  end
end
