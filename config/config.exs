use Mix.Config
config :elixir, ansi_enabled: true
config :encrypt, encryption_key: System.get_env("ENCRYPTION_KEY")
