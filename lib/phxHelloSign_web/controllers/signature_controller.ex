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
end
