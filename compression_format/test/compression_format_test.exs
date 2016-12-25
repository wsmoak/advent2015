defmodule CompressionFormatTest do
  use ExUnit.Case
  doctest CompressionFormat

  test "example 1" do
    str = "ABC(3x3)DEF(1x3)F"
    assert Regex.split(~r{\(.*?\)},str,include_captures: true, parts: 2) == ["ABC", "(3x3)", "DEF(1x3)F"]
    # This splits the string into anything before the command, the command, and the rest
  end

  test "example 2" do
    str = "(3x3)DEF(1x3)F"
    assert Regex.split(~r{\(.*?\)},str,include_captures: true, parts: 2) == ["", "(3x3)", "DEF(1x3)F"]
    # If there is nothing before the command, the first position is an empty string
  end

  test "example 3" do
    CompressionFormat.Agent.reset
    CompressionFormat.process( "ADVENT" )
    assert CompressionFormat.Agent.get == ["ADVENT"]
    assert CompressionFormat.Agent.get_length == 6
  end

  test "example 4" do
    CompressionFormat.Agent.reset
    CompressionFormat.process( "A(1x5)BC" )
    assert CompressionFormat.Agent.get == ["C","BBBBB","A"]
    assert CompressionFormat.Agent.get_length == 7
  end

  test "example 5" do
    CompressionFormat.Agent.reset
    CompressionFormat.process( "(3x3)XYZ" )
    assert CompressionFormat.Agent.get == ["", "XYZXYZXYZ", ""]
    assert CompressionFormat.Agent.get_length == 9
  end

  test "example 6" do
    CompressionFormat.Agent.reset
    CompressionFormat.process( "A(2x2)BCD(2x2)EFG" )
    assert CompressionFormat.Agent.get == ["G", "EFEF", "D", "BCBC", "A"]
    assert CompressionFormat.Agent.get_length == 11
  end

  test "example 7" do
    CompressionFormat.Agent.reset
    CompressionFormat.process( "(6x1)(1x3)A" )
    assert CompressionFormat.Agent.get == ["", "(1x3)A", ""]
    assert CompressionFormat.Agent.get_length == 6
  end

  test "example 8" do
    CompressionFormat.Agent.reset
    CompressionFormat.process( "X(8x2)(3x3)ABCY" )
    assert CompressionFormat.Agent.get == ["Y", "(3x3)ABC(3x3)ABC", "X"]
    assert CompressionFormat.Agent.get_length == 18
  end
end
