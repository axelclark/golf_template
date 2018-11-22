defmodule Golf.Scorecard do
  @moduledoc """
  The Scorecard context.
  """

  import Ecto.Query, warn: false
  alias Golf.Repo

  alias Golf.Scorecard.Course

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Course{}, ...]

  """
  def list_courses do
    Repo.all(Course)
  end

  @doc """
  Gets a single course.

  Raises `Ecto.NoResultsError` if the Course does not exist.

  ## Examples

      iex> get_course!(123)
      %Course{}

      iex> get_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_course!(id), do: Repo.get!(Course, id)

  @doc """
  Creates a course.

  ## Examples

      iex> create_course(%{field: value})
      {:ok, %Course{}}

      iex> create_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a course.

  ## Examples

      iex> update_course(course, %{field: new_value})
      {:ok, %Course{}}

      iex> update_course(course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Course.

  ## Examples

      iex> delete_course(course)
      {:ok, %Course{}}

      iex> delete_course(course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking course changes.

  ## Examples

      iex> change_course(course)
      %Ecto.Changeset{source: %Course{}}

  """
  def change_course(%Course{} = course) do
    Course.changeset(course, %{})
  end

  alias Golf.Scorecard.Hole

  @doc """
  Returns the list of holes.

  ## Examples

      iex> list_holes()
      [%Hole{}, ...]

  """
  def list_holes do
    Hole
    |> preload(:course)
    |> Repo.all()
  end

  @doc """
  Gets a single hole.

  Raises `Ecto.NoResultsError` if the Hole does not exist.

  ## Examples

      iex> get_hole!(123)
      %Hole{}

      iex> get_hole!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hole!(id), do: Repo.get!(Hole, id)

  @doc """
  Creates a hole.

  ## Examples

      iex> create_hole(%{field: value})
      {:ok, %Hole{}}

      iex> create_hole(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hole(attrs \\ %{}) do
    %Hole{}
    |> Hole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hole.

  ## Examples

      iex> update_hole(hole, %{field: new_value})
      {:ok, %Hole{}}

      iex> update_hole(hole, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hole(%Hole{} = hole, attrs) do
    hole
    |> Hole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hole.

  ## Examples

      iex> delete_hole(hole)
      {:ok, %Hole{}}

      iex> delete_hole(hole)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hole(%Hole{} = hole) do
    Repo.delete(hole)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hole changes.

  ## Examples

      iex> change_hole(hole)
      %Ecto.Changeset{source: %Hole{}}

  """
  def change_hole(%Hole{} = hole) do
    Hole.changeset(hole, %{})
  end
end
