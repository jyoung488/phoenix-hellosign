defmodule PhxHelloSignWeb.PageController do
  use PhxHelloSignWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
