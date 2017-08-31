defmodule PhxHelloSignWeb.SignatureController do
  use PhxHelloSignWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
