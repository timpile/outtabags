defmodule OuttabagsWeb.PageView do
  use OuttabagsWeb, :view

  alias OuttabagsWeb.LocationView

  def google_staticmap_img_tag(id: id, locations: locations) do
    LocationView.google_staticmap_img_tag(id: id, locations: locations)
  end
end
