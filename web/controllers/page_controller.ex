defmodule Resume.PageController do
  use Resume.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
