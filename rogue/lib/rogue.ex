defmodule Rogue do
  @moduledoc """
  2016 Advent of Code Day 18
  """

  @input "^^^^......^...^..^....^^^.^^^.^.^^^^^^..^...^^...^^^.^^....^..^^^.^.^^...^.^...^^.^^^.^^^^.^^.^..^.^"

  def solve do
    solve(@input, 40)
  end

  def solve_part_2 do
    solve(@input, 400000)
  end

  def solve(input,height) when is_binary(input) and is_integer(height) do
    width = String.length(input)
    grid = make_map(input, 0) |> add_outer_columns(height, width)

    grid = solve(grid, 1, height, width)
    count_safe_tiles(grid, height, width)
  end

  def count_safe_tiles(grid, height, width) do
    (for x <- 0..width-1, y <- 0..height-1, do: {x,y})
    |> Enum.map(fn key -> Map.get(grid, key) end)
    |> Enum.filter(fn item -> item == "." end)
    |> Enum.count
    |> IO.inspect
  end

  def make_map(input, row) do
    input
    |> String.codepoints
    |> Enum.with_index
    |> Enum.map(fn { item, col} -> { {col, row}, item } end )
    |> Enum.reduce(%{},fn {key,value}, map -> Map.put(map, key, value) end )
  end

  # add a column of "safe" tiles on either side
  def add_outer_columns(grid, height, width) do
    ( for y <- 0..height-1, do: [ {-1,y}, {width, y} ] )
    |> List.flatten
    |> Enum.reduce(grid, fn key, map -> Map.put(map, key, ".") end )
  end

  # recursively fill in the grid
  def solve(grid, row_num, height, width) when row_num < height do
    (for col <- 0..width-1, do: {col, row_num})
    |> Enum.reduce(grid, &calculate/2 )
    |> solve(row_num + 1, height, width)
  end

  def solve(grid, row_num, height, width) when row_num >= height do
    grid
  end

  def calculate( {x,y} , map) do
    left = Map.get(map, {x-1,y-1})
    center = Map.get(map, {x, y-1})
    right = Map.get(map, {x+1, y-1})

    if trap?("#{left}#{center}#{right}") do
      map = Map.put(map, {x,y}, "^")
    else
      map = Map.put(map, {x,y}, ".")
    end
    map
  end

  def trap?("^^."), do: true
  def trap?(".^^"), do: true
  def trap?("^.."), do: true
  def trap?("..^"), do: true
  def trap?(_), do: false

end
