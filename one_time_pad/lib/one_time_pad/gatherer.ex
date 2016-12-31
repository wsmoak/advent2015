alias Experimental.GenStage

# TODO: this needs to be a producerconsumer and called "Decider"
# then we need a final consumer that gathers up the first 64
# TODO:  This part can be parallelized

defmodule OneTimePad.Gatherer do
  use GenStage

  def init(:no_args) do
    {:consumer, []}
  end

  def handle_events(this_is_a_key, _from, state) do

    state = [ this_is_a_key | state ]

    IO.puts "In Gatherer, I have #{Enum.count(state)} keys now."

    if Enum.count(state) == 64 do
      {:stop, "found 64 keys at index #{ hd(this_is_a_key) }", state}
    else
      {:noreply, [], state}
    end

  end
end
