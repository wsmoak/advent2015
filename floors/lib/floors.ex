defmodule Floors do

  def count(input) when is_binary input do
    input
    |> to_char_list
    |> count
  end

  def count(input) when is_list input do
    count({input,0})
  end

  def count({[], accum}) do
    accum
  end

  def count({[h|t], accum}) do
    answer =
      case h do
        40 -> accum = accum + 1
        41 -> accum = accum - 1
        _  -> accum
      end
    count({t,answer})
  end

  def position(input) when is_binary input do
    input
    |> to_char_list
    |> position
  end

  def position(input) when is_list input do
    position({input,0,0})
  end

  def position( {_, pos, -1}) do
    pos
  end

  def position( {[h|t], pos, accum}) do
    answer =
      case h do
        40 -> accum = accum + 1
        41 -> accum = accum - 1
        _  -> accum
      end
    position({t, pos+1, answer})
  end

end
