defmodule Golf.Scorecard.Round do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rounds" do
    field :started_on, :date
    field :course_id, :id

    timestamps()
  end

  @doc false
  def changeset(round, attrs) do
    round
    |> cast(attrs, [:started_on])
    |> validate_required([:started_on])
  end
end
