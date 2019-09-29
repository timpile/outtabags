defmodule Outtabags.Location do
  alias Outtabags.Repo
  alias Outtabags.Location.GeoTag

  def list_geo_tags do
    GeoTag
    |> Repo.all()
  end

  def get_geo_tag!(id) do
    GeoTag
    |> Repo.get!(id)
  end

  def create_geo_tag(attrs) do
    clean_attrs = clean_coordinates(attrs)
    %GeoTag{}
    |> GeoTag.changeset(clean_attrs)
    |> Repo.insert()
  end

  def update_geo_tag(%GeoTag{} = geo_tag, attrs) do
    geo_tag
    |> GeoTag.changeset(attrs)
    |> Repo.update()
  end

  def delete_geo_tag(%GeoTag{} = geo_tag) do
    Repo.delete(geo_tag)
  end

  def change_geo_tag(%GeoTag{} = geo_tag) do
    GeoTag.changeset(geo_tag, %{})
  end

  defp clean_coordinates(attrs) do
    %{
      "device_info" => attrs["device_info"],
      "lat" => cast_to_float(attrs["lat"]),
      "lng" => cast_to_float(attrs["lng"]),
    }
  end

  defp cast_to_float(str) do
    case Float.parse(str) do
      {float, _} -> float
      :error -> str
    end
  end
end
