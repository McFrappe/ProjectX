defmodule Lopptor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LopptorWeb.Telemetry,
      # Start the Ecto repository
      Lopptor.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lopptor.PubSub},
      # Start Finch
      {Finch, name: Lopptor.Finch},
      # Start the Endpoint (http/https)
      LopptorWeb.Endpoint
      # Start a worker by calling: Lopptor.Worker.start_link(arg)
      # {Lopptor.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lopptor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LopptorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
