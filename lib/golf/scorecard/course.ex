defmodule Golf.Scorecard.Course do
  use Ecto.Schema
  import Ecto.Changeset


  schema "courses" do
    field :name, :string
    field :num_holes, :integer
    has_many :holes, Golf.Scorecard.Hole
    has_many :rounds, Golf.Scorecard.Round

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :num_holes])
    |> validate_required([:name, :num_holes])
    |> unique_constraint(:name)
  end
end
