defmodule OuttabagsWeb.LocationController do
  use OuttabagsWeb, :controller
  alias Outtabags.Location
  alias Outtabags.Location.GeoTag

  def index(conn, _params) do
    geo_tags = Location.list_geo_tags()
    render(conn, "index.html", geo_tags: geo_tags)
  end

  def new(conn, _params) do
    changeset = Location.change_geo_tag(%GeoTag{})
    render(conn, "new.html", changeset: changeset, geo_tag: nil)
  end

  def create(conn, %{"geo_tag" => geo_tag_params}) do
    case Location.create_geo_tag(geo_tag_params) do
      {:ok, geo_tag} ->
        conn
        |> put_flash(:info, "#{geo_tag.device_info} created!")
        |> redirect(to: Routes.location_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    geo_tag = Location.get_geo_tag!(id)
    render(conn, "show.html", geo_tag: geo_tag)
  end

  def edit(conn, %{"id" => id}) do
    geo_tag = Location.get_geo_tag!(id)
    changeset = Location.change_geo_tag(geo_tag)
    render(conn, "edit.html", geo_tag: geo_tag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "geo_tag" => geo_tag_params}) do
    geo_tag = Location.get_geo_tag!(id)
    case Location.update_geo_tag(geo_tag, geo_tag_params) do
      {:ok, _geo_tag} ->
        conn
        |> put_flash(:info, "Geo tag updated successfully.")
        |> redirect(to: Routes.location_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", geo_tag: geo_tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    geo_tag = Location.get_geo_tag!(id)
    {:ok, _geo_tag} = Location.delete_geo_tag(geo_tag)

    conn
    |> put_flash(:info, "Geo tag deleted successfully.")
    |> redirect(to: Routes.location_path(conn, :index))
  end
end
