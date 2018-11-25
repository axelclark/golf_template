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

  test "createCourse field errors with an existing name", %{conn: conn} do
    Golf.Scorecard.create_course(%{name: "Mercer Park", num_holes: 9})
    course = %{
      "name" => "Mercer Park",
      "numHoles" => 18,
    }

    conn = post conn, "/api",
      query: @query,
      variables: %{"course" => course}

    assert json_response(conn, 200) == %{
      "data" => %{"course" => nil},
      "errors" => [
        %{
          "details" => %{"name" => ["has already been taken"]},
          "locations" => [%{"column" => 0, "line" => 2}],
          "message" => "Couldn't create course",
          "path" => ["course"]
        }
      ]
    }
  end
end
