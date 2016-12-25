defmodule TwoFactorAuthAgent do

  @last_row 5
  @last_col 49

  def start_link do
    Agent.start_link(&make_map/0, name: __MODULE__)
  end

  def make_map do
    tuples = for x <- 0..@last_col, y <- 0..@last_row, do: {x,y}
    Map.new(tuples, fn key -> {key, 0} end)
  end

  def get(x,y) when is_binary(x) and is_binary(y) do
    {a,_} = Integer.parse(x)
    {b,_} = Integer.parse(y)
    get(a,b)
  end

  def get(x,y) when is_integer(x) and is_integer(y) do
    Agent.get(__MODULE__, Map, :get, [{x,y}])
  end

  def fill_rectangle(x,y) when is_binary(x) and is_binary(y) do
    {a,_} = Integer.parse(x)
    {b,_} = Integer.parse(y)
    fill_rectangle(a,b)
  end

  # fills in from 0,0 to x,y with 1's
  def fill_rectangle(x,y) when is_integer(x) and is_integer(y) do
    for a <- 0..x-1, b <- 0..y-1, do:
      Agent.update(
        __MODULE__,
        fn(old_state) -> Map.update!(old_state, {a,b}, fn(_) -> 1 end) end
      )
  end

  def rotate_row(row,qty) when is_binary(row) and is_binary(qty) do
    {a,_} = Integer.parse(row)
    {b,_} = Integer.parse(qty)
    rotate_row(a,b)
  end

  def rotate_row(row,qty) when is_integer(row) and is_integer(qty) do
    rotated_row = get_row(row) |> rotate_list(qty)

    list_of_tuples = Enum.with_index(rotated_row)

    Enum.each(list_of_tuples, fn({value, col}) ->
      Agent.update(
        __MODULE__,
        fn(old_state) -> Map.update!(old_state, {col,row}, fn(_) -> value end) end
      ) end
    )
  end

  def get_row(row) when is_integer(row) do
    for col <- 0..49, do: get(col,row)
  end

  # rotates the row right by one
#  def rotate_row(cols) when is_list(cols) do
#    last_col = Enum.count(cols)-1
#    last = List.last(cols)
#    rest = List.delete_at(cols, last_col)
#    List.wrap(last) ++ rest
#  end

  # take the 'qty' elements off the end and stick them on the front
  def rotate_list(list,qty) when is_list(list) and is_integer(qty) do
    size = length(list)
    first_part = Enum.slice(list, 0..size-qty-1)
    last_part = Enum.slice(list, size-qty..size-1)
    last_part ++ first_part
  end

  def rotate_col(col,qty) when is_binary(col) and is_binary(qty) do
    {a,_} = Integer.parse(col)
    {b,_} = Integer.parse(qty)
    rotate_col(a,b)
  end

  def rotate_col(col,qty) when is_integer(col) and is_integer(qty) do
    rotated_col = get_col(col) |> rotate_list(qty)

    list_of_tuples = Enum.with_index(rotated_col)

    Enum.each(list_of_tuples, fn({value, row}) ->
      Agent.update(
        __MODULE__,
        fn(old_state) -> Map.update!(old_state, {col,row}, fn(_) -> value end) end
      ) end
    )
  end


  def get_col(col) when is_integer(col) do
    for row <- 0..@last_row, do: get(col,row)
  end

  def get_total do
    (for row <- 0..5, do: TwoFactorAuthAgent.get_row(row)) |> List.flatten |> Enum.sum
  end
end
