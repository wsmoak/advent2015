alias Experimental.GenStage

# TODO: this needs to be a producerconsumer and called "Decider"
# then we need a final consumer that gathers up the first 64
# TODO:  This part can be parallelized

defmodule OneTimePad.Decider do
  use GenStage

  def init(args \\ []) do
    {:producer_consumer, :no_state}
  end

  def handle_events([ {index, [triple], next_1000 } ], _from, :no_state) do

    pattern = String.first(triple) |> String.duplicate(5)

    IO.puts "In Decider, handle_events, received: #{index} #{triple} and #{ Enum.count(next_1000) }"

    # Decide whether this is a key.  Does the next_1000 contain 5 of the same character?
    if Enum.any?( next_1000, &has_quintuple?(&1,pattern) ) do
      IO.puts "Found a key at #{index}"
      {:noreply, [index], :no_state}
    else
      {:noreply, [], :no_state}
    end
  end

  def has_quintuple?({item, _index}, pattern) do
    String.contains?(item, pattern)
  end
end
