defmodule Presents do

  def paper_amount(%{filename: filename}) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/K2TI1j6BgIY
    stream = File.stream!(filename, [:read, :utf8], :line)
    accum = 0
    Enum.reduce(stream, accum, &paper_amount(&1,&2) )
  end

  def paper_amount([l,w,h]) do
    length = String.to_integer(l)
    width =  String.to_integer(w)
    height = h |> String.rstrip |> String.to_integer
    paper_amount(length,width,height)
  end

  def paper_amount(line,accum) do
    values = String.split(line,"x")
    accum + paper_amount(values)
  end

  def paper_amount(l,w,h) do
    the_top = l*w
    a_side = h*l
    an_end = w*h
    smallest = Enum.min( [the_top, a_side, an_end])

    2*the_top + 2*a_side + 2*an_end + smallest
  end

  def ribbon_amount(%{filename: filename}) do
    # https://groups.google.com/forum/#!topic/elixir-lang-talk/K2TI1j6BgIY
    stream = File.stream!(filename, [:read, :utf8], :line)
    accum = 0
    Enum.reduce(stream, accum, &ribbon_amount(&1,&2) )
  end

  def ribbon_amount([l,w,h]) do
    length = String.to_integer(l)
    width =  String.to_integer(w)
    height = h |> String.rstrip |> String.to_integer
    ribbon_amount(length,width,height)
  end

  def ribbon_amount(line,accum) do
    values = String.split(line,"x")
    accum + ribbon_amount(values)
  end

  def ribbon_amount(l,w,h) do
    ribbon = 2 * Enum.min([l+w,w+h,l+h])
    bow = l*w*h
    ribbon + bow
  end
end
