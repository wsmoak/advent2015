defmodule Strings do

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
    !is_naughty?(line) && has_repeating_char?(line) && has_three_vowels?(line)
  end

  def is_naughty?(line) do
    String.contains?(line,["ab","cd","pq","xy"])
  end

  def has_repeating_char?(line) do
    String.match?( line, ~r/(.)\1{1,}/ )
  end

  def has_three_vowels?(line) do
    vowel_count(line,0) >= 3
  end

  def vowel_count("",accum) do
    accum
  end

  def vowel_count(line,accum) do
    {first,rest} = String.split_at(line,1)
    if String.contains?(first,["a","e","i","o","u"]) do
      vowel_count(rest,accum+1)
    else
      vowel_count(rest,accum)
    end
  end

end
