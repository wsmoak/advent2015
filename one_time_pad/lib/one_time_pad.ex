alias Experimental.GenStage

defmodule OneTimePad do
  @moduledoc """
  Advent of Code 2016 Day 14
  """

  # http://stackoverflow.com/questions/7147810/regular-expression-same-character-3-times
  # http://elixir-lang.org/blog/2016/07/14/announcing-genstage/

  @input "yjdafjpo"

  # have some process that can generate md5's
  # pull some from it and keep a queue
  # see if the head of the list has a triple in it, and what that is if so
  # if yes send "this one" and the letter plus "next thousand" to a process to decide
  # otherwise discard this one and try the next
  # stop at 64 of them

  def solve do
    solve(@input)
  end

  def solve(input) do
    {:ok, hash_producer} = GenStage.start_link(OneTimePad.HashProducer, {0, input}, name: MyHashProducer )
    {:ok, worker} = GenStage.start_link(OneTimePad.Worker, :no_args, name: MyWorker)
    {:ok, decider} = GenStage.start_link(OneTimePad.Decider, :no_args, name: MyDecider)
    {:ok, gatherer} = GenStage.start_link(OneTimePad.Gatherer, :no_args, name: MyGatherer)

    GenStage.sync_subscribe(gatherer, to: decider)
    GenStage.sync_subscribe(decider, to: worker)
    GenStage.sync_subscribe(worker, to: hash_producer)

    Process.sleep(:infinity)
  end

end
