defmodule PhxHelloSignWeb.SignatureController do
  use PhxHelloSignWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def info(conn, _params) do
    api_key = Application.get_env(:phxHelloSign, :app_vars)[:api_key]
    id = conn.params["signature"]["id"]
    url = "https://#{api_key}:@api.hellosign.com/v3/signature_request/#{id}"

    response = HTTPotion.get url
    data = Poison.decode!(response.body)

    %{"signature_request" => signature_request} = data
    # %{"signature_request_id" => signature_request_id, "test_mode" => test_mode, "title" => title,
    #   "response_data" => response_data}

    render conn, "info.html", signature_request: signature_request
  end

  def list(conn, _params) do
    api_key = Application.get_env(:phxHelloSign, :app_vars)[:api_key]
    url = "https://#{api_key}:@api.hellosign.com/v3/signature_request/list"

    response = HTTPotion.get url
    data = response.body
    |> Poison.decode!

    %{"list_info" => list_info, "signature_requests" => signature_requests} = data

    render conn, "list.html", signature_requests: signature_requests, list_info: list_info
  end

  def send(conn, _params) do
    api_key = Application.get_env(:phxHelloSign, :app_vars)[:api_key]
    url = "https://#{api_key}:@api.hellosign.com/v3/signature_request/send"

    content = Poison.encode!(%{"signers": [%{"name": "Jen", "email_address": "jen.young+1@hellosign.com"}],
    "title": "Phoenix Test",
    "subject": "Test subject",
    "file_url": "https://i.pinimg.com/736x/d4/6b/ce/d46bceba9774e062581df3a1dff47864--corgi-tattoo-art-shows.jpg",
    "test_mode": 1,
    "client_id": "b7deafb6c27f6131f5cb67adf94d0454"})

    IO.inspect content

    response = HTTPotion.post url, [body: content, headers: ["User-Agent": "Phoenix App", "Content-Type": "application/json"]]

    IO.inspect response

    render conn, "send.html", response: response
  end
end
