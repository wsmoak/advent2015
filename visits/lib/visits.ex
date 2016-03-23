defmodule Visits do

  def houses(input) do
    chars = to_char_list input
    accum = %{ :x => 0, :y => 0, "x0y0" => nil}
    answer = Enum.reduce(chars, accum, &check_it(&1,&2))
    Map.size(answer)-2
  end

  def with_robot(input) do
    chars = to_char_list input
    santa = chars |> Enum.take_every(2)
    {_first,second} = chars |> Enum.split(1)
    robo = second |> Enum.take_every(2)
    accum = %{ :x => 0, :y => 0, "x0y0" => nil}
    answer_santa = Enum.reduce(santa, accum, &check_it(&1,&2))
    answer_robo = Enum.reduce(robo, accum, &check_it(&1,&2))
    answer = Map.merge(answer_santa, answer_robo)
    Map.size(answer)-2
  end

  def check_it(item,accum) do
    answer =
      case item do
        60 ->
          accum |> Map.put("x#{accum[:x]+1}y#{accum[:y]}",nil) |> Map.put(:x, accum[:x]+1)
        62 ->
          accum |> Map.put("x#{accum[:x]-1}y#{accum[:y]}",nil) |> Map.put(:x, accum[:x]-1)
        94 ->
          accum |> Map.put("x#{accum[:x]}y#{accum[:y]+1}",nil) |> Map.put(:y, accum[:y]+1)
        118 ->
          accum |> Map.put("x#{accum[:x]}y#{accum[:y]-1}",nil) |> Map.put(:y, accum[:y]-1)

      end
    answer
  end
end
