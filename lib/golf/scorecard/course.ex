defmodule Golf.Scorecard.Course do
  use Ecto.Schema
  import Ecto.Changeset


  schema "courses" do
    field :holes, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :holes])
    |> validate_required([:name, :holes])
  end
end
