defmodule TwoFactorAuthTest do
  use ExUnit.Case
  doctest TwoFactorAuth


  test "example 1" do
    TwoFactorAuth.process("rect 2x2")
    assert TwoFactorAuthAgent.get(0,0) == 1
    assert TwoFactorAuthAgent.get(0,1) == 1
    assert TwoFactorAuthAgent.get(1,0) == 1
    assert TwoFactorAuthAgent.get(1,1) == 1
  end

  @cols [1,2,3,4,5,6,7,8,9]
  test "example 3" do
    assert TwoFactorAuthAgent.rotate_list(@cols, 1) == [9,1,2,3,4,5,6,7,8]
  end

  test "example 4" do
    assert TwoFactorAuthAgent.rotate_list(@cols, 3) == [7,8,9,1,2,3,4,5,6]
  end

  test "example 5" do
    TwoFactorAuth.process("rect 2x2")
    TwoFactorAuth.process("rotate row y=0 by 4")

    assert TwoFactorAuthAgent.get_row(0) == [0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  test "example 6" do
    TwoFactorAuth.process("rect 2x2")
    TwoFactorAuth.process("rotate column x=1 by 2")

    assert TwoFactorAuthAgent.get_col(1) == [0,0,1,1,0,0]
  end

  test "example 7" do
    TwoFactorAuth.process("rect 6x2")
    TwoFactorAuth.process("rotate column x=5 by 1")

    assert TwoFactorAuthAgent.get_col(5) == [0,1,1,0,0,0]
  end

  test "example 8" do
    TwoFactorAuth.process("rect 3x2")

    assert TwoFactorAuthAgent.get_row(0) == [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert TwoFactorAuthAgent.get_row(1) == [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert TwoFactorAuthAgent.get_row(2) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  test "example 9" do
    TwoFactorAuth.process("rect 1x1")

    assert TwoFactorAuthAgent.get_row(0) == [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert TwoFactorAuthAgent.get_row(1) == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

end
