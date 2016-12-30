# https://www.khanacademy.org/computing/computer-science/algorithms/breadth-first-search/a/the-breadth-first-search-algorithm
# http://erlang.org/doc/man/queue.html#new-0

defmodule Maze do

  defstruct position: nil, distance: 0

  @input 1362

  def solve do
    solve({1,1},{31,39},@input)
  end

  def solve(start_pos,end_pos,favorite) do
     bfs(start_pos, end_pos, _distance = 0, _visited = :queue.new, _todo = :queue.new,favorite)
  end

  def wall?({x,y}) do
    wall?({x,y}, @input)
  end

  def wall?(0), do: false
  def wall?(1), do: true

  def wall?({x,y}, favorite) do
    x*x + 3*x + 2*x*y + y + y*y + favorite
    |> Integer.digits(2) # list of 0's and 1's
    |> Enum.sum
    |> rem(2)
    |> wall?
  end


  # breadth-first search
  def bfs(start_pos,end_pos,distance, _visited, _todo, _favorite) when start_pos == end_pos do
    IO.puts "DONE!"
    IO.inspect start_pos
    IO.inspect end_pos
    IO.inspect distance
  end

  def bfs(_start, _finish, distance, visited, _todo, _favorite) when distance > 50 do
    IO.puts "I have visited this many locations in at most 50 steps"
    visited
    |> :queue.to_list
    |> Enum.map(fn item -> item.position end)
    |> Enum.uniq
    |> Enum.count
    |> IO.inspect
  end

  def bfs(start = {start_x, start_y}, finish, distance, visited, todo, favorite) when distance <= 50 do
    # add this position to the visited queue
    visited = :queue.in(
      %Maze{position: start, distance: distance},
      visited
    )

    # add to queue all the valid adjacent positions, adding 1 to current distance.
    next = adjacent({start_x, start_y})
    |> Enum.filter(fn pos -> pos != {start_x, start_y} end)
    |> Enum.filter(fn pos -> !wall?(pos,favorite) end)
    |> Enum.filter(fn pos -> !visited?(pos,visited) end)
    |> Enum.filter(fn {x,y} -> x >= 0 && y>= 0 end)
    |> Enum.map(fn x -> %Maze{position: x, distance: distance + 1} end )
    |> :queue.from_list

    IO.puts "I am at #{inspect start}, #{distance} from the start. The possible places to go are:"
    IO.inspect next
    IO.puts ""

    todo = :queue.join(todo,next)
    {{:value, item}, todo} = :queue.out(todo)

    bfs(item.position, finish, item.distance, visited, todo, favorite)
  end

  def visited?(pos, visited) do
    Enum.any?(:queue.to_list(visited), fn x -> x.position == pos end)
  end

  def adjacent({start_x, start_y}) do
    [
      {start_x-1, start_y},
      {start_x,   start_y-1},
      {start_x,   start_y+1},
      {start_x+1, start_y}
    ]
  end
end
