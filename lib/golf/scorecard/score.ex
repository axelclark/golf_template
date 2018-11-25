defmodule Golf.Scorecard.Score do
  use Ecto.Schema
  import Ecto.Changeset


  schema "scores" do
    field :num_strokes, :integer
    field :hole_id, :id
    field :round_id, :id

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:num_strokes])
    |> validate_required([:num_strokes])
  end
end
