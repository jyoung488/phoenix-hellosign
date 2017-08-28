defmodule PhxHelloSignWeb.AccountController do
  use PhxHelloSignWeb, :controller



  def index(conn, _params) do
    render conn, "index.html"
  end

  def info(conn, _params) do
    api_key = Application.get_env(:phxHelloSign, :app_vars)[:api_key]

    url = "https://#{api_key}:@api.hellosign.com/v3/account"

    response = HTTPotion.get url
    body = response.body

    data = Poison.decode!(body)

    IO.inspect data

    %{"account" => account} = data

    %{"account_id" => account_id, "email_address" => email} = account


    render conn, "info.html", account_id: account_id, email: email
  end

  # defp initiate_client do
  #
  # end
end

#https://0f09c444c7b8b650844cfb4ceb387191a02b9e3ca241c757574d72448080ebd6@api.hellosign.com/v3/account
