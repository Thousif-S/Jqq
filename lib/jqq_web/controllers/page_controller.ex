defmodule JqqWeb.PageController do
  use JqqWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
