alias Experimental.GenStage

defmodule OneTimePad.Worker do
  use GenStage

  def init(args \\ []) do
    {:producer_consumer, :queue.new }
  end

  def handle_subscribe(_calling_process_is_a = :consumer, options, from, state) do
    IO.puts "In Worker handle_subscribe, args is :consumer, options is #{inspect options}, from is #{inspect from}, state is #{inspect state}"

    # for the worker, as a producer, return :automatic
    {:automatic, state}
  end

  # https://hexdocs.pm/gen_stage/Experimental.GenStage.html#module-asynchronous-work-and
  def handle_subscribe(_calling_process_is_a = :producer, options, from, state) do
    IO.puts "In Worker handle_subscribe, args is :producer, options is #{inspect options}, from is #{inspect from}, state is #{inspect state}"

    #check_and_ask(state, from) # start the loop that keeps the queue filled up
    Process.send_after( self(), {:ask, from}, 5000 )

    # for the worker, as a consumer, return :manual indicating that it will ask when it wants more events
    {:manual, state}
  end

  def handle_events(events, _from, _state = q) do

    IO.puts "In Worker, the first event is: #{inspect hd(events)}"

    q = :queue.join( q, :queue.from_list(events) )

    IO.puts "In Worker, I have #{:queue.len(q)} things in the queue now."

    Process.send_after( self(), :do_work, 15) # start the loop that does the work

    {:noreply, [], q }
  end

  def handle_info(:do_work, q) do
    event = []

    if :queue.len(q) > 1001 do

      # pop the first value off the queue
      { {:value, { item, index } }, q} = :queue.out(q)

      #IO.puts "Looking for triple in #{item} at index #{index}"
      triple = find_triple(item)

      if triple != nil do
        { next_1000, _ } = :queue.split(1000, q) # remember q is unchanged

        # emit an "event" with
        # - the index of the hash with the triple,
        # - the triple (or the letter that was duplicated)
        # - A list of the next 1000 hashes to be checked.
        event = [ {index, triple, :queue.to_list(next_1000) } ]
      end

    else
      IO.puts "There aren't enough things in the queue right now."
    end

    Process.send_after( self(), :do_work, 15 )

    #if event != [], do: IO.puts "In worker, emitting an event... #{inspect event}"

    {:noreply, event, q }
  end

  def handle_info({:ask, from}, state) do
    #IO.puts "In Worker handle_info :ask"

    if :queue.len(state) < 2500 do
      IO.puts "In Worker, asking for more items"
      GenStage.ask(from, 2500)
    end
    Process.send_after( self(), {:ask, from}, 5000 )

    {:noreply, [], state}
  end

  def find_triple(item) do
    # IO.inspect input
    Regex.run(~r/(.)\1\1/, item, capture: :first)
  end
end
