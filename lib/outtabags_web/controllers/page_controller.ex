defmodule OuttabagsWeb.PageController do
  use OuttabagsWeb, :controller

  alias Outtabags.Location

  def index(conn, _params) do
    locations = Location.list_geo_tags()
    render(conn, "index.html", locations: locations)
  end
end
