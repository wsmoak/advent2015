defmodule Monorail do
  @moduledoc """
  Advent of Code 2016 Day 12

  Needs improvement.  Both parts take a long time to run.
  """

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    input
    |> String.split("\n")
    |> process
  end

  # Start with zero in each regigister. Start on the first instruction.
  def process(instructions) when is_list(instructions) do
    process(instructions, 0, %{a: 0, b: 0, c: 1, d: 0})
  end

  def process(instructions, index, registers) when is_list(instructions) and is_integer(index) do
    IO.inspect registers
    instr = instructions |> Enum.at(index)
    process(instr, instructions, index, registers)
  end

  # index is outside the list of instructions, so we're done
  def process(nil, _instructions, _index, registers) do
    IO.inspect registers
  end

  def process(instruction, instructions, index, registers) when is_binary(instruction) do
    instruction
    |> String.split
    |> IO.inspect
    |> process(instructions, index, registers)
  end

  # If from is an integer, use it, otherwise get the integer out of the given register
  def process(["cpy", from, to], instructions, index, registers) when is_binary(from) and is_binary(to) do
    case Integer.parse(from) do
      {from, ""} ->
        process(["cpy", from, String.to_atom(to)], instructions, index, registers)
      :error ->
        from = Map.get(registers, String.to_atom(from))
        process(["cpy", from, String.to_atom(to)], instructions, index, registers)
    end
  end

  # Copy an integer to a register
  def process(["cpy", from, to], instructions, index, registers) when is_integer(from) and is_atom(to) do

    registers = Map.update!(registers, to, fn _ -> from end)
    process(instructions, index+1, registers)
  end

  def process(["inc",register], instructions, index, registers) do
    registers = Map.update!(registers, String.to_atom(register), &(&1+1))
    process(instructions, index+1, registers)
  end

  def process(["dec",register], instructions, index, registers) do
    registers = Map.update!(registers, String.to_atom(register), &(&1-1))
    process(instructions, index+1, registers)
  end

  def process(["jnz",register, move], instructions, index, registers) do
    if Map.get(registers, String.to_atom(register)) != 0 do
      {move, _} = Integer.parse(move)
      process(instructions, index+move, registers)
    else
      process(instructions, index+1, registers)
    end
  end
end
