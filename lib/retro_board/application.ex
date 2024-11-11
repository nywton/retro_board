defmodule RetroBoard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RetroBoardWeb.Telemetry,
      RetroBoard.Repo,
      {DNSCluster, query: Application.get_env(:retro_board, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RetroBoard.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RetroBoard.Finch},
      # Start a worker by calling: RetroBoard.Worker.start_link(arg)
      # {RetroBoard.Worker, arg},
      # Start to serve requests, typically the last entry
      RetroBoardWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RetroBoard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RetroBoardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
