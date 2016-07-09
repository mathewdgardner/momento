defmodule Momento.Mixfile do
  use Mix.Project

  def project do
    [
      app: :momento,
      version: "0.1.1",
      description: description(),
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [espec: :test, coveralls: :test],
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls, test_task: "espec"]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:espec, "~> 0.8", only: :test},
      {:excoveralls, "~> 0.5", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:inch_ex, only: :docs}
    ]
  end

  defp description do
    """
    Momento is an Elixir port of Moment.js for the purpose of parsing, validating, manipulating, and formatting dates.
    """
  end

  defp package do
    [
      name: :momento,
      files: ["lib", "mix.exs", "README.md", "LICENSE",],
      maintainers: ["Mathew Gardner <mathewdgardner@gmail.com>"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/mathewdgardner/momento"
      }
    ]
  end
end
