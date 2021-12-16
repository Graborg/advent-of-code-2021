defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Day14

  @tag :skip
  test "part1" do
    input =
      """
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
      """
      |> String.split("\n", trim: true)
      |> IO.inspect()

    result = part1(input)

    # assert result == "NCNBCHB"
    #  assert result == "NBCCNBBBCBHCB"
    assert result == 1588
  end

  @tag :skip
  test "part1withInput" do
    input =
      AdventOfCode.Input.get!(14, 2021)
      |> String.split("\n", trim: true)

    result = part1(input)
    IO.inspect(result, label: "\n Answer d14p01")
    assert result == 3306
  end

  @tag :skip
  test "part2" do
    input =
      """
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
      """
      |> String.split("\n", trim: true)
      |> IO.inspect()

    result = part2(input)

    assert result == 2_188_189_693_529
  end
end
