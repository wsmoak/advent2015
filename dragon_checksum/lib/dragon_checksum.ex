defmodule DragonChecksum do
  @moduledoc """
  Documentation for DragonChecksum.
  """

  @input "00111101111101000"
  @max_length 272

  def solve do
    solve(@input, @max_length)
  end

  def solve(input, max_length) do
    answer = dragon(input, max_length)
    checksum(answer)
  end

  def dragon(input, max_length) when byte_size(input) < max_length do
    dragon( input <> "0" <> reverse_xor(input), max_length)
  end

  def dragon(input, max_length) when byte_size(input) >= max_length do
    String.slice(input, 0, max_length)
  end

  def reverse_xor(input) do
    input
    |> String.reverse
    |> String.codepoints
    |> Enum.map(fn x -> if x == "0", do: "1", else: "0" end)
    |> Enum.join
  end

  # when length of string is even
  def checksum(input) when rem(byte_size(input),2) == 0 do
    input
    |> String.codepoints
    |> Enum.chunk(2)
    |> Enum.map(fn [a,b] -> if a == b, do: "1", else: "0" end)
    |> Enum.join
    |> checksum
  end

  # previous function head didn't match, so length must be odd and this is our answer
  def checksum(input), do: input
end
