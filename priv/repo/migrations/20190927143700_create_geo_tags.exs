defmodule Outtabags.Repo.Migrations.CreateLocationTags do
  use Ecto.Migration

  def change do
    create table(:geo_tags) do
      add :device_info, :string
      add :geom, :geometry

      timestamps()
    end

    create index(:geo_tags, [:geom], using: :gist)
  end
end
