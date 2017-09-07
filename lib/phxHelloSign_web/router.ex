defmodule PhxHelloSignWeb.Router do
  use PhxHelloSignWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxHelloSignWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/account", PhxHelloSignWeb do
    pipe_through :browser

    get "/", AccountController, :index
    get "/info", AccountController, :info
    get "/update", AccountController, :update
    get "/verify", AccountController, :verify
  end

  scope "/signatures", PhxHelloSignWeb do
    pipe_through :browser

    get "/", SignatureController, :index
    get "/info", SignatureController, :info
    post "/info", SignatureController, :info
    get "/list", SignatureController, :list
    get "/send", SignatureController, :send
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxHelloSignWeb do
  #   pipe_through :api
  # end
end
