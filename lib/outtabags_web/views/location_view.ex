defmodule OuttabagsWeb.LocationView do
  use OuttabagsWeb, :view

  alias Outtabags.Location

  def lat(%Location.GeoTag{geom: geom}) do
    {lat, _lng} = geom.coordinates
    lat
  end
  def lat(nil), do: nil

  def lng(%Location.GeoTag{geom: geom}) do
    {_lat, lng} = geom.coordinates
    lng
  end
  def lng(nil), do: nil

  def google_staticmap_img_src(size: size, zoom: zoom) do
    base_url = "https://maps.googleapis.com/maps/api/staticmap"
    api_key = Dotenv.get("GOOGLE_MAPS_API_KEY", "")
    base_url <> "?key=" <> api_key <> "&size=" <> size <> "&zoom=" <> zoom
  end
  def google_staticmap_img_src() do
    google_staticmap_img_src(size: "300x200", zoom: "8")
  end

  def google_staticmap_img_tag(id: id) do
    img_src = google_staticmap_img_src()
    img_tag(img_src, [id: id])
  end

  def google_staticmap_img_tag(id: id, locations: locations) do
    img_src = google_staticmap_img_src(size: "500x400", zoom: "15")
      <> markers_params(locations)
      <> "&center=35.58888,-78.58888"
    img_tag(img_src, [id: id])
  end

  def markers(locations) do
    for location <- locations do
      location.geom.coordinates
      |> Tuple.to_list()
      |> Enum.join(",")
    end
    |> Enum.join("|")
  end

  def markers_params(locations) do
    "&markers=" <> markers(locations)
  end
end
