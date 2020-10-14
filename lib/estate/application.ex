defmodule Estate.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Estate.Repo,
      # Start the Telemetry supervisor
      EstateWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Estate.PubSub},
      # Start the Endpoint (http/https)
      EstateWeb.Endpoint
      # Start a worker by calling: Estate.Worker.start_link(arg)
      # {Estate.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Estate.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EstateWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
