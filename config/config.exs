# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phxHelloSign,
  ecto_repos: [PhxHelloSign.Repo]

# Configures the endpoint
config :phxHelloSign, PhxHelloSignWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G0nYSMfC0Z8P/Bo7+826EZR2diOPEu2hV4umFbfTVLWag8s9i+cs75FntaMGDdub",
  render_errors: [view: PhxHelloSignWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxHelloSign.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
