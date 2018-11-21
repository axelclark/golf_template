defmodule Golf.ScorecardTest do
  use Golf.DataCase

  alias Golf.Scorecard

  describe "courses" do
    alias Golf.Scorecard.Course

    @valid_attrs %{holes: 42, name: "some name"}
    @update_attrs %{holes: 43, name: "some updated name"}
    @invalid_attrs %{holes: nil, name: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scorecard.create_course()

      course
    end

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert Scorecard.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Scorecard.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = Scorecard.create_course(@valid_attrs)
      assert course.holes == 42
      assert course.name == "some name"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scorecard.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, %Course{} = course} = Scorecard.update_course(course, @update_attrs)
      assert course.holes == 43
      assert course.name == "some updated name"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Scorecard.update_course(course, @invalid_attrs)
      assert course == Scorecard.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Scorecard.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Scorecard.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Scorecard.change_course(course)
    end
  end
end
