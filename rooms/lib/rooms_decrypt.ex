defmodule RoomsDecrypt do
  @moduledoc """
  Documentation for Rooms.
  """

  def process do
    {:ok, input} = File.read("/Users/wsmoak/input.txt")
    input |> process
  end

  def process(input) do
    input
    |> String.strip
    |> String.split("\n")
    |> Enum.filter(&real?/1)
    |> Enum.map(&decrypt/1)
  end

  def search do
    {:ok, input} = File.read("/Users/wsmoak/input.txt")
    input |> search
  end

  # Look for a room with 'object' in the name
  def search(input) do
    input
    |> process
    |> Enum.filter(&Enum.member?(&1,'object'))
  end

  @doc """
      iex> RoomsDecrypt.decrypt(["","","343","ivhz", "zixmtkozy", "qzmt"])
      ["343", 'very', 'encrypted', 'name']
  """
  def decrypt([_, _, sector_id | rest]) do
    {amt_to_shift, _} = Integer.parse(sector_id)
    rest # this is the 'words' in reverse order
    |> Enum.map(&decrypt(&1,amt_to_shift))
    |> Enum.reverse
    |> Enum.into([sector_id])
  end

  def decrypt(input) do
    input
    |> String.split(["-","[","]"])
    |> Enum.reverse
    |> decrypt
  end

  def decrypt(word,sector_id) do
    word
    |> String.to_charlist
    |> Enum.map(&shift(&1, sector_id))
  end

  @doc """
  shift the codepoint forward through the alphabet the number of times. (modulo?  26 times is back where we started.)

      iex> RoomsDecrypt.shift(99,1) # c -> d
      100

      iex> RoomsDecrypt.shift(122,1) # z -> a
      97
  """
  def shift(letter, number) do
    letter = letter - 97 # ?a is 97
    number = rem(number,26) # no point in going round and round
    answer = letter + number
    rem(answer,26) + 97 # add the offset to 'a' to 'wrap around'
  end

  @doc """
  Drop the first element. Splitting on ] produces an empty string at the end of the list (which we then reverse.) Returns true if the checksums match

  #    iex> RoomsDecrypt.real?("aaaaa-bbb-z-y-x-123[abxyz]")
  #    true
  """
  def real?([_, provided_checksum, _sector_id | rest]) do
    Rooms.calculated_checksum(rest) == provided_checksum
  end

  def real?(input) do
    input
    |> String.split(["-","[","]"])
    |> Enum.reverse
    |> real?
  end

end
