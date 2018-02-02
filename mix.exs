defmodule TextClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :text_client,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :captacion_agua]
    ]
  end

  defp deps do
    [
      {:captacion_agua, git: "https://github.com/ismqui/captaci-n_agua.git"},
    ]
  end
end
