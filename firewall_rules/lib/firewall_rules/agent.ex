defmodule FirewallRules.Agent do

  def start_link do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def put([a,b]) when is_binary(a) and is_binary(b) do
    put( Integer.parse(a), Integer.parse(b) )
  end

  def put( {a,_}, {b,_} ) when is_integer(a) and is_integer(b) do
      Agent.update(
        __MODULE__,
        fn(old_state) -> if old_state+1 >= a do b else old_state end end
      )
  end

  # Returns the current state, the list of pieces of the result
  def get do
    Agent.get(__MODULE__, &(&1) )
  end

  def reset do
    Agent.update(
      __MODULE__,
      fn(_old_state) -> 0 end
    )
  end
end
