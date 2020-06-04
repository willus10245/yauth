# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :yauth, YauthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xUvVAt5X+0W43gHzW1gTTFGeOVzK3cV/JvYnSEiQ8WTIWTkGBdtoGHxPL02OtAdg",
  render_errors: [view: YauthWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Yauth.PubSub,
  live_view: [signing_salt: "wHDZbHD2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []},
    identity:
      {Ueberauth.Strategy.Identity,
       [
         param_nesting: "account",
         request_path: "/register",
         callback_path: "/register",
         callback_methods: ["POST"]
       ]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :yauth, YauthWeb.Authentication,
  issuer: "yauth",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
