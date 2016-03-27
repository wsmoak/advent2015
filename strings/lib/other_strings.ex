defmodule OtherStrings do

  def nice_strings(%{filename: filename}) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/K2TI1j6BgIY
    stream = File.stream!(filename, [:read, :utf8], :line)
    accum = 0
    Enum.reduce(stream, accum, &nice_strings(&1,&2) )
  end

  def nice_strings(line,accum) do
    if is_nice?(line) do
      accum + 1
    else
      accum
    end
  end

  def is_nice?(line) do
    has_repeating_pair?(line) && has_pair_with_one_between?(line)
  end

  def has_repeating_pair?(line) do
    String.match?( line, ~r/(..).*\1{1,}/ )
  end

  def has_pair_with_one_between?(line) do
    String.match?( line, ~r/(.).\g{1}/ )
  end

end
