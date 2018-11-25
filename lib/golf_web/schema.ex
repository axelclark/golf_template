defmodule GolfWeb.Schema do
  use Absinthe.Schema
  import_types GolfWeb.Schema.ScorecardTypes

  alias GolfWeb.Resolvers

  mutation do
    field :create_course, :course do
      arg :input, non_null(:course_input)
      resolve &Resolvers.Scorecard.create_course/3
    end
  end

  query do
    @desc "Get all courses"
    field :courses, list_of(:course) do
      resolve &Resolvers.Scorecard.list_courses/3
    end

    @desc "Get a hole on a course"
    field :hole, :hole do
      arg :id, non_null(:id)
      resolve &Resolvers.Scorecard.find_hole/3
    end
  end
end
