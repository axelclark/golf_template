defmodule Golf.ScorecardTest do
  use Golf.DataCase

  alias Golf.Scorecard

  describe "courses" do
    alias Golf.Scorecard.Course

    @valid_attrs %{num_holes: 42, name: "some name"}
    @update_attrs %{num_holes: 43, name: "some updated name"}
    @invalid_attrs %{num_holes: nil, name: nil}

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
      assert course.num_holes == 42
      assert course.name == "some name"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scorecard.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, %Course{} = course} = Scorecard.update_course(course, @update_attrs)
      assert course.num_holes == 43
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

  describe "holes" do
    alias Golf.Scorecard.Hole

    @valid_attrs %{hole_number: 42, par: 42}
    @update_attrs %{hole_number: 43, par: 43}
    @invalid_attrs %{hole_number: nil, par: nil}
    @course_attrs %{name: "A", num_holes: 18}

    def hole_fixture(attrs \\ %{}) do
      {:ok, course} = Scorecard.create_course(@course_attrs)

      {:ok, hole} =
        attrs
        |> Map.put(:course_id, course.id)
        |> Enum.into(@valid_attrs)
        |> Scorecard.create_hole()

      hole
    end

    test "list_holes/0 returns all holes" do
      hole = hole_fixture()

      [result] = Scorecard.list_holes()
      assert hole.id == result.id
    end

    test "get_hole!/1 returns the hole with given id" do
      hole = hole_fixture()
      assert Scorecard.get_hole!(hole.id) == hole
    end

    test "create_hole/1 with valid data creates a hole" do
      {:ok, course} = Scorecard.create_course(@course_attrs)
      attrs = Map.put(@valid_attrs, :course_id, course.id)

      assert {:ok, %Hole{} = hole} = Scorecard.create_hole(attrs)
      assert hole.hole_number == 42
      assert hole.par == 42
    end

    test "create_hole/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scorecard.create_hole(@invalid_attrs)
    end

    test "update_hole/2 with valid data updates the hole" do
      hole = hole_fixture()
      assert {:ok, %Hole{} = hole} = Scorecard.update_hole(hole, @update_attrs)
      assert hole.hole_number == 43
      assert hole.par == 43
    end

    test "update_hole/2 with invalid data returns error changeset" do
      hole = hole_fixture()
      assert {:error, %Ecto.Changeset{}} = Scorecard.update_hole(hole, @invalid_attrs)
      assert hole == Scorecard.get_hole!(hole.id)
    end

    test "delete_hole/1 deletes the hole" do
      hole = hole_fixture()
      assert {:ok, %Hole{}} = Scorecard.delete_hole(hole)
      assert_raise Ecto.NoResultsError, fn -> Scorecard.get_hole!(hole.id) end
    end

    test "change_hole/1 returns a hole changeset" do
      hole = hole_fixture()
      assert %Ecto.Changeset{} = Scorecard.change_hole(hole)
    end
  end

  describe "rounds" do
    alias Golf.Scorecard.Round

    @valid_attrs %{started_on: ~D[2010-04-17]}
    @update_attrs %{started_on: ~D[2011-05-18]}
    @invalid_attrs %{started_on: nil}

    def round_fixture(attrs \\ %{}) do
      {:ok, round} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scorecard.create_round()

      round
    end

    test "list_rounds/0 returns all rounds" do
      round = round_fixture()
      assert Scorecard.list_rounds() == [round]
    end

    test "get_round!/1 returns the round with given id" do
      round = round_fixture()
      assert Scorecard.get_round!(round.id) == round
    end

    test "create_round/1 with valid data creates a round" do
      assert {:ok, %Round{} = round} = Scorecard.create_round(@valid_attrs)
      assert round.started_on == ~D[2010-04-17]
    end

    test "create_round/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scorecard.create_round(@invalid_attrs)
    end

    test "update_round/2 with valid data updates the round" do
      round = round_fixture()
      assert {:ok, %Round{} = round} = Scorecard.update_round(round, @update_attrs)
      assert round.started_on == ~D[2011-05-18]
    end

    test "update_round/2 with invalid data returns error changeset" do
      round = round_fixture()
      assert {:error, %Ecto.Changeset{}} = Scorecard.update_round(round, @invalid_attrs)
      assert round == Scorecard.get_round!(round.id)
    end

    test "delete_round/1 deletes the round" do
      round = round_fixture()
      assert {:ok, %Round{}} = Scorecard.delete_round(round)
      assert_raise Ecto.NoResultsError, fn -> Scorecard.get_round!(round.id) end
    end

    test "change_round/1 returns a round changeset" do
      round = round_fixture()
      assert %Ecto.Changeset{} = Scorecard.change_round(round)
    end
  end

  describe "scores" do
    alias Golf.Scorecard.Score

    @valid_attrs %{num_strokes: 42}
    @update_attrs %{num_strokes: 43}
    @invalid_attrs %{num_strokes: nil}

    def score_fixture(attrs \\ %{}) do
      {:ok, score} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scorecard.create_score()

      score
    end

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Scorecard.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Scorecard.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      assert {:ok, %Score{} = score} = Scorecard.create_score(@valid_attrs)
      assert score.num_strokes == 42
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scorecard.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      assert {:ok, %Score{} = score} = Scorecard.update_score(score, @update_attrs)
      assert score.num_strokes == 43
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Scorecard.update_score(score, @invalid_attrs)
      assert score == Scorecard.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Scorecard.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Scorecard.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Scorecard.change_score(score)
    end
  end
end
