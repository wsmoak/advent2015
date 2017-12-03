defmodule InverseCaptchaTest do
  use ExUnit.Case

  # Part 1

  test "1122 returns 3" do
    assert InverseCaptcha.process("1122") == 3
  end

  test "1111 returns 4" do
    assert InverseCaptcha.process("1111") == 4
  end

  test "1234 returns 0" do
    assert InverseCaptcha.process("1234") == 0
  end

  test "91212129 returns 9" do
    assert InverseCaptcha.process("91212129") == 9
  end

  # Part 2

  test "1212 returns 6" do
    assert InverseCaptcha.solve("1212") == 6
  end

  test "1221 returns 0" do
    assert InverseCaptcha.solve("1221") == 0
  end

  test "123425 returns 4" do
    assert InverseCaptcha.solve("123425") == 4
  end

  test "123123 returns 12" do
    assert InverseCaptcha.solve("123123") == 12
  end

  test "12131415 returns 4" do
    assert InverseCaptcha.solve("12131415") == 4
  end

 end
