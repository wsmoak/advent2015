defmodule CoinsTest do
  use ExUnit.Case
  doctest Coins

  test "abcdef for 5" do
    assert Coins.mine5("abcdef") == 609043
  end

  test "pqrstuv for 5" do
    assert Coins.mine5("pqrstuv") == 1048970
  end

  test "yzbqklnj for 5" do
    assert Coins.mine5("yzbqklnj") == 282749
  end

  test "yzbqklnj for 6" do
    assert Coins.mine6("yzbqklnj") == 9962624
  end

end
