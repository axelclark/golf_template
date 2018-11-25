defmodule GolfWeb.Schema.Mutation.CreateCourseTest do
  use GolfWeb.ConnCase

  @query """
  mutation ($course: CourseInput!) {
    course: createCourse(input: $course) {
      name
      numHoles
    }
  }
  """
  test "createCourse field creates a course", %{conn: conn} do
    course = %{
      "name" => "Mercer Park",
      "numHoles" => 18,
    }
    conn = post conn, "/api",
      query: @query,
      variables: %{"course" => course}

    assert json_response(conn, 200) == %{
      "data" => %{
       "course" => %{
          "name" => course["name"],
          "numHoles" => course["numHoles"]
        }
      }
    }
  end
end
