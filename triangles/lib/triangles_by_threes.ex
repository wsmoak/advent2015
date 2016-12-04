defmodule TrianglesByThrees do
  @moduledoc """
  Documentation for TrianglesByThrees.
  """

  def count_valid(input) do
    input
    |> String.split("\n")
    |> Enum.chunk(3)
    |> Enum.map(&transform/1)
    |> List.flatten
    |> Enum.filter(&Triangles.valid?/1)
    |> Enum.count

  end

    @doc """
    # process three lines of input and re-arrange so we can use the original code

      iex> TrianglesByThrees.transform([" 1 2 3 ","4 5 6","7 8  9"])
      ["1 4 7","2 5 8","3 6 9"]
  """
  def transform(three_elements) do
    [[a1,a2,a3],[b1,b2,b3],[c1,c2,c3]] = Enum.map(three_elements, &String.split/1)
    ["#{a1} #{b1} #{c1}", "#{a2} #{b2} #{c2}", "#{a3} #{b3} #{c3}"]
  end

end
