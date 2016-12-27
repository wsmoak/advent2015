defmodule BalanceBots.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: BalanceBots.Worker.start_link(arg1, arg2, arg3)
      # worker(BalanceBots.Worker, [arg1, arg2, arg3]),

      # the simple one for one specification can define only one child which works as a template for when we call start_child/2
      worker(BalanceBots.Worker, [], restart: :transient)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options

    # http://elixir-lang.org/docs/stable/elixir/Supervisor.html#module-simple-one-for-one
    # Use Simple one for one and dynamically start children
    opts = [strategy: :simple_one_for_one, name: BalanceBots.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
