defmodule Lights.BrightnessWorker do
  use GenServer

  # Client

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: BrightnessWorker)
  end

  def process(%{filename: filename}) do
    stream = File.stream!(filename, [:read, :utf8], :line)
    Enum.each(stream, &process(&1))
  end

  def process("turn on " <> rest) do
    IO.puts "increasing brightness by 1..."
    process(:turn_on, parse(rest) )
  end

  def process("turn off " <> rest) do
    IO.puts "decreasing brightness by 1..."
    process(:turn_off, parse(rest) )
  end

  def process("toggle " <> rest) do
    IO.puts "increasing brightness by 2..."
    process(:toggle, parse(rest) )
  end

  def parse(rest) do
    rest = String.replace(rest,"\n","")
    [start, stop] = String.split(rest,[" through ","\n"])
    [start_row, start_col] = String.split(start,",")
    [stop_row, stop_col] = String.split(stop,",")
    IO.puts start_row <> " " <> stop_row <> " " <> start_col <> " " <> stop_col

    [start_row, stop_row, start_col, stop_col] |> Enum.map( &String.to_integer(&1) )
  end

  def process(action, [start_row, stop_row, start_col, stop_col] ) do
    for row <- start_row..stop_row, col <- start_col..stop_col do
        :ok = GenServer.call(BrightnessWorker, {action, row, col})
      end
  end

  def count do
    GenServer.call(BrightnessWorker, :count)
  end

  # Server (callbacks)

  def handle_call({:turn_on, row, col}, from, state) do
    {new_val, state} = Map.get_and_update(state, {row,col}, fn val -> {val, (if val == nil, do: 1, else: val + 1) } end )
    {:reply, :ok, state}
  end

  def handle_call({:turn_off, row, col}, from, state) do
    {new_val, state} = Map.get_and_update(state, {row,col}, fn val -> {val, decrease(val) } end )
    {:reply, :ok, state}
  end

  def decrease(val) when val == nil, do: 0
  def decrease(val) when val == 0, do: 0
  def decrease(val), do: val - 1

  def handle_call({:toggle, row, col}, from, state) do
    {new_val, state} = Map.get_and_update(state, {row,col}, fn val -> {val, (if val == nil, do: 2, else: val + 2) } end )
    {:reply, :ok, state}
  end

  def handle_call(:count, from, state) do
    # start with 0.
    # for each element of the Map, which looks like this
    # {row,col} => 1 or {row,col} => 0
    # add the value (1 or 0) to the accumulator
    # this will show how many lights are "on"
    answer = Enum.reduce(state, 0, fn({_key, value}, accum) -> accum + value  end )
    {:reply, answer, state}
  end

  def handle_cast(request, state) do
    super(request, state)
  end
end
