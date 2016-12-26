defmodule CompressionFormatPart2Test do
  use ExUnit.Case
  doctest CompressionFormatPart2

  test "example 1" do
    assert CompressionFormatPart2.process( "(3x3)XYZ" ) == 9
  end

  # X(8x2)(3x3)ABCY becomes XABCABCABCABCABCABCY, because the decompressed data from the (8x2) marker is then further decompressed, thus triggering the (3x3) marker twice for a total of six ABC sequences.
  test "example 2" do
    assert CompressionFormatPart2.process( "X(8x2)(3x3)ABCY" ) == 20
  end

  # (27x12)(20x12)(13x14)(7x10)(1x12)A decompresses into a string of A repeated 241920 times.
  test "example 3" do
    assert CompressionFormatPart2.process( "(27x12)(20x12)(13x14)(7x10)(1x12)A" ) == 241920
  end

  # (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN becomes 445 characters long.
  test "example 4" do
    assert CompressionFormatPart2.process( "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN" ) == 445
  end
end
