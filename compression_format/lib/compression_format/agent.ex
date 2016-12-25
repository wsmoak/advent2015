defmodule CompressionFormat.Agent do

  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  # Adds another piece of the result to the list
  def put(input) when is_binary(input) do
    Agent.update(
        __MODULE__,
        fn(old_state) -> [ input | old_state ] end
      )
  end

  # Returns the current state, the list of pieces of the result
  def get do
    Agent.get(__MODULE__, &(&1) )
  end

  def get_length do
    Agent.get(__MODULE__, &(&1) )
    |> Enum.join
    |> String.length
  end

  def reset do
    Agent.update(
      __MODULE__,
      fn(_old_state) -> [] end
    )
  end
end
