defmodule OuttabagsWeb.PageController do
  use OuttabagsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
