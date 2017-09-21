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

    content = Poison.encode!(%{"signers": [%{"name": "Jen", "email_address": "jen.young+1@hellosign.com"}, %{"name": "Jen 2", "email_address": "jyoung488@gmail.com"}],
    "title": "Phoenix Test",
    "subject": "Test subject",
    "file_url": "https://i.pinimg.com/736x/d4/6b/ce/d46bceba9774e062581df3a1dff47864--corgi-tattoo-art-shows.jpg",
    "test_mode": 1})

    response = HTTPotion.post url, [body: content, headers: ["User-Agent": "Phoenix App", "Content-Type": "application/json"]]

    render conn, "send.html", response: response
  end

  def send_template(conn, _params) do
    api_key = Application.get_env(:phxHelloSign, :app_vars)[:api_key]
    url = "https://#{api_key}:@api.hellosign.com/v3/signature_request/send_with_template"

    content = Poison.encode!(%{"signers": %{"Client": %{"name": "Jen", "email_address": "jen.young+1@hellosign.com"}},
    "template_id": "5b7d915246886b0f9125bf06c0e5180d147bd3ba",
    "subject": "Test subject",
    "test_mode": 1})

    response = HTTPotion.post url, [body: content, headers: ["User-Agent": "Phoenix App", "Content-Type": "application/json"]]

    render conn, "send_template.html", response: response
  end

  def send_reminder(conn, _params) do
    api_key = Application.get_env(:phxHelloSign, :app_vars)[:api_key]
    id = conn.params["signature"]["id"]
    email = conn.params["signature"]["email"]
    name = conn.params["signature"]["name"]
    url = "https://#{api_key}:@api.hellosign.com/v3/signature_request/remind/#{id}"

    content = Poison.encode!(%{"email_address": email, "name": name})

    response = HTTPotion.post url, [body: content, headers: ["User-Agent": "Phoenix App", "Content-Type": "application/json"]]

    render conn, "send_reminder.html", response: response
  end
end
