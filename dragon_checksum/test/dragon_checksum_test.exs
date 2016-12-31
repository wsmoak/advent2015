defmodule DragonChecksumTest do
  use ExUnit.Case
  doctest DragonChecksum

  test "example 1" do
    assert DragonChecksum.dragon("1",3) == "100"
  end

  test "example 2" do
    assert DragonChecksum.dragon("0",3) == "001"
  end

  test "example 3" do
    assert DragonChecksum.dragon("11111",11) == "11111000000"
  end

  test "example 4" do
    assert DragonChecksum.dragon("111100001010", 25) == "1111000010100101011110000"
  end

  test "example 5" do
    assert DragonChecksum.checksum("110010110100") == "100"
  end

  test "example 6" do
    assert DragonChecksum.solve("10000", 20) == "01100"
  end

end
