defmodule Elephant do

  @input 3005290

  def solve do
    solve(@input)
  end

  # See https://www.youtube.com/watch?v=uCsD3ZGzMgE
  # via https://www.reddit.com/r/adventofcode/comments/5j4lp1/2016_day_19_solutions/
  # Express in binary and move first digit to the end
  def solve(input) when is_integer(input) do
    list = Integer.digits(input,2)
    [first  | rest] = list
    new_list = rest ++ [ first ]
    Integer.undigits(new_list,2)
  end

end
