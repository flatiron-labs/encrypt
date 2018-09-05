defmodule Encrypt.MixProject do
  use Mix.Project

  def project do
    [
      app: :encrypt,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      name: "encrypt",
      description: "Command-line encryption engine."
      organization: "flatironschool",
      source_url: "https://github.com/flatiron-labs/encrypt",
      homepage_url: "https://github.com/flatiron-labs/encrypt",
      package: package()
    ]
  end

  def package do
    licenses: ["MIT License"],
    links: %{"Github" => "https://github.com/flatiron-labs/encrypt"},
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript do
    [main_module: Encrypt.Cli]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
