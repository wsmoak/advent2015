defmodule RoomsDecryptTest do
  use ExUnit.Case
  doctest RoomsDecrypt

  test "example 1" do
    input = "qzmt-zixmtkozy-ivhz-343[zimth]\nqzmt-zixmtkozy-ivhz-343[zimth]"
    assert RoomsDecrypt.process(input) == [["343", 'very', 'encrypted', 'name'], ["343", 'very', 'encrypted', 'name']]
  end
end
