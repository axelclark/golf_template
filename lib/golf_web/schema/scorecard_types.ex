defmodule GolfWeb.Schema.ScorecardTypes do
  use Absinthe.Schema.Notation

  @desc "A golf course"
  object :course do
    field :id, :id
    field :name, :string
    field :num_holes, :integer
    field :holes, list_of(:hole) do
      resolve &GolfWeb.Resolvers.Scorecard.holes_for_course/3
    end
  end

  @desc "Inputs to create a course"
  input_object :course_input do
    field :name, non_null(:string)
    field :num_holes, non_null(:integer)
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
