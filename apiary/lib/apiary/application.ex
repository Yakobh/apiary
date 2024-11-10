defmodule Apiary.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ApiaryWeb.Telemetry,
      Apiary.Repo,
      {DNSCluster, query: Application.get_env(:apiary, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Apiary.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Apiary.Finch},
      # Start a worker by calling: Apiary.Worker.start_link(arg)
      # {Apiary.Worker, arg},
      # Start to serve requests, typically the last entry
      ApiaryWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Apiary.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApiaryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
