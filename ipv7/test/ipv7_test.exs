defmodule Ipv7Test do
  use ExUnit.Case
  doctest Ipv7

  test "example 1" do
    input = "abcdefghijkl[mnopqrst]abcdefcddc"
    assert Ipv7.supports_tls?(input) == true
  end

  test "example 2" do
    assert Ipv7.get_abas("xsldkjabasdfshlkj") == ["aba"]
  end

  test "example 3" do
    assert Ipv7.get_abas(["zazbz","cdb"]) == ["zaz","zbz"]
  end

  test "example 4" do
    assert Ipv7.supports_ssl?("zazbz[bzb]cdb") == true
  end
end
