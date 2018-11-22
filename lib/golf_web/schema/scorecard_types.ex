defmodule GolfWeb.Schema.ScorecardTypes do
  use Absinthe.Schema.Notation

  @desc "A golf course"
  object :course do
    field :id, :id
    field :name, :string
    field :num_holes, :integer
    field :holes, list_of(:hole)
  end

  @desc "A hole on a course"
  object :hole do
    field :id, :id
    field :hole_number, :string
    field :par, :integer
    field :course_id, :integer
    field :course, :course
  end
end
