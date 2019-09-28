defmodule Outtabags.GeoTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "geo_tags" do
    field :device_info, :string
    field :geom, Geo.PostGIS.Geometry

    timestamps()
  end

  @doc false
  def changeset(geo_tag, attrs) do
    geo_tag
    |> cast(attrs, [:device_info, :geom])
    |> validate_required([:device_info, :geom])
  end
end
