defmodule Outtabags.Location.GeoTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "geo_tags" do
    field :device_info, :string
    field :lat, :float, virtual: true
    field :lng, :float, virtual: true
    field :geom, Geo.PostGIS.Geometry

    timestamps()
  end

  @doc false
  def changeset(geo_tag, attrs) do
    # parsed_attrs = parse_coordinates(attrs)
    IO.inspect(attrs)
    geo_tag
    |> cast(attrs, [:device_info, :lat, :lng])
    |> validate_required([:device_info, :lat, :lng])
    |> put_geom()
  end

  defp put_geom(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{lat: lat, lng: lng}} -> put_change(changeset, :geom, %Geo.Point{coordinates: {lat, lng}, properties: %{}, srid: 4326})
      _ ->
        changeset
    end
  end
end
