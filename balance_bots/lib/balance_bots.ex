defmodule BalanceBots do
  @moduledoc """
  Documentation for BalanceBots.
  """

  def solve do
    {:ok, input} = File.read("input.txt")
    input |> String.strip |> solve
  end

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.each(&process(&1))
  end

  def find_result do
    Process.whereis( BalanceBots.Supervisor )
    |> Supervisor.which_children
    |> Enum.filter(fn {_,pid,_,_} -> BalanceBots.Worker.get_values(pid) == [61,17] end )
  end

  def process(input) when is_binary(input) do
    input
    |> String.split
    |> process
  end

  def process( ["value", value, "goes", "to", type = "bot", num] ) when is_binary(value) do
    {value,_} = Integer.parse(value)
    pid = find_or_create_worker(type,num)
    send_value(value, pid)
  end

  def process( [type = "bot", bot_num, "gives", "low", "to", low_type, low_num, "and", "high", "to", high_type, high_num] ) do
    bot_pid = find_or_create_worker(type,bot_num)
    low_pid = find_or_create_worker(low_type,low_num)
    high_pid = find_or_create_worker(high_type,high_num)
    send_instruction(bot_pid, low_pid, high_pid)
  end

  def send_value(value, pid) when is_integer(value) and is_pid(pid) do
    GenServer.cast(pid, {:set_value, value})
  end

  def send_instruction(bot_pid, low_pid, high_pid) when is_pid(bot_pid) and is_pid(low_pid) and is_pid(high_pid) do
    # send it a message
    GenServer.cast(bot_pid, {:send_to, low_pid, high_pid})
  end

  def find_or_create_worker(type,number) do
    name = (type <> number) |> String.to_atom
    Process.whereis(name) || create_worker(name)
  end

  def create_worker(name) do
    sup_pid = Process.whereis( BalanceBots.Supervisor )
    {:ok, bot_pid} = Supervisor.start_child(sup_pid, [[], [name: name]])
    bot_pid
  end
end
