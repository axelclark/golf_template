defmodule Golf.Repo.Migrations.AddIndexForCourseNames do
  use Ecto.Migration

  def change do
    create unique_index(:courses, [:name])
  end
end
