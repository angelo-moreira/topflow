defmodule TopflowWeb.PageController do
  use TopflowWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
