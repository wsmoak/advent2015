defmodule Ipv7Test do
  use ExUnit.Case
  doctest Ipv7

  test "example 1" do
    input = "abcdefghijkl[mnopqrst]abcdefcddc"
    assert Ipv7.supports_tls?(input) == true
  end

end
