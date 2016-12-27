defmodule BalanceBots.Worker do
  use GenServer

   @enforce_keys [:name]
  defstruct name: nil, values: [], send_low_to: nil, send_high_to: nil

  # Client

  def start_link(_state, opts) do
    GenServer.start_link(__MODULE__, [ opts[:name] ], name: opts[:name] )
  end

  def get_values(pid) do
    GenServer.call(pid, :values)
  end

  def get_state(pid) do
    GenServer.call(pid, :state)
  end

  # Server (callbacks)

  def init([name]) do
    {:ok, %BalanceBots.Worker{name: name}}
  end

  def handle_call(:values, _from, state) do
    {:reply, state.values, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set_value, value}, state) do
    IO.puts "In BalanceBots.Worker handle_call :set_value"
    new_state = %{state | values: [value | state.values] }
    Process.send_after(self(), :evaluate, 1_000)
    {:noreply, new_state}
  end

  def handle_cast({:send_to, bot_num_low, bot_num_high}, state) do
    IO.puts "In BalanceBots.Worker handle_cast :send_to"
    new_state = %{state | send_low_to: bot_num_low, send_high_to: bot_num_high}
    Process.send_after(self(), :evaluate, 1_000)
    {:noreply, new_state}
  end

  def handle_info(:evaluate, state) do
    # do we have two values and instructions on what to do with them?
    if Enum.count(state.values) == 2 && state.send_low_to != nil && state.send_high_to != nil do
      [low,high] = Enum.sort(state.values)
      if low == 17 and high == 61 do
        IO.puts "FOUND IT >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{state.name}"
      end
      GenServer.cast(state.send_low_to, {:set_value, low})
      GenServer.cast(state.send_high_to, {:set_value, high})
      state = %{ state | values: []}
    end
    {:noreply, state}
  end
end
