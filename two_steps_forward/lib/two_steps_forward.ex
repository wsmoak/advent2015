alias TwoStepsForward, as: TSF

defmodule TwoStepsForward do

  defstruct position: nil, path: nil

  @input "dmypynyp"

  def solve do
    solve(@input)
  end

  def solve(input) do
    bfs(%TSF{ position: {0,0}, path: "" }, input, :queue.new, :queue.new)
  end

  # We have arrived at the bottom right corner
  def bfs(item = %TSF{position: {3,3}, path: path}, input, q, done) do
    IO.puts "Found a path of length #{String.length(path)}"
    done = :queue.in(item, done)

#    IO.inspect done

#    {{:value, item}, q} = :queue.out(q)
#    IO.inspect item
#    bfs(item, input, q, done)
    next(input, q, done)

  end

  # breadth-first search
  def bfs( item = %TSF{ position: {start_x, start_y}, path: path}, input, _todo = q, done) when start_x >= 0 and start_x <= 3 and start_y >= 0 and start_y <= 3 do
    [up, down, left, right] = hash( input <> path )
    if up, do: q = :queue.in( %TSF{path: path <> "U", position: {start_x,start_y-1} }, q)
    if down, do: q = :queue.in(%TSF{path: path <> "D", position: {start_x,start_y+1} }, q)
    if left, do: q = :queue.in(%TSF{path: path <> "L", position: {start_x-1,start_y} }, q)
    if right, do: q = :queue.in(%TSF{path: path <> "R", position: {start_x+1,start_y} }, q)

    IO.puts "There are #{:queue.len(q)} items in the queue."

#   IO.inspect q

#    {{:value, item}, q} = :queue.out(q)
#    IO.inspect item
#    bfs(item, input, q, done)
    next(input, q, done)

  end

  def bfs( item, input, q, done) do
    IO.puts "Skipping item with position outside the grid"
#    {{:value, item}, q} = :queue.out(q)
#    IO.inspect item
#    bfs(item, input, q, done)
    next(input, q, done)
  end

  def next(input, q, done) do
    case :queue.out(q) do
      {{:value, item}, q} ->
        bfs(item, input, q, done)
      {:empty, q} ->
        find_longest(done)
    end
  end

  def find_longest(q) do
    q
    |> :queue.to_list
    |> Enum.map(fn item -> item.path end)
    |> Enum.map(fn path -> String.length(path) end)
    |> Enum.max
  end

  def hash(input) do
    input
    |> :erlang.md5
    |> Base.encode16
    |> String.downcase
    |> String.slice(0,4)
    |> String.codepoints
    |> Enum.map(&open?/1)
  end

  def open?("a"), do: false
  def open?("b"), do: true
  def open?("c"), do: true
  def open?("d"), do: true
  def open?("e"), do: true
  def open?("f"), do: true
  def open?("1"), do: false
  def open?("2"), do: false
  def open?("3"), do: false
  def open?("4"), do: false
  def open?("5"), do: false
  def open?("6"), do: false
  def open?("7"), do: false
  def open?("8"), do: false
  def open?("9"), do: false
  def open?("0"), do: false
end
