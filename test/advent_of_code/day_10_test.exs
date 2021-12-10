defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  @tag :skip
  test "part1" do
    input =
      """
      {([(<{}[<>[]}>{[]{[(<()>
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      """
      |> String.split("\n", trim: true)

    result = part1(input)

    assert result == 26397
  end

  @tag :skip
  test "part1withInput" do
    input =
      AdventOfCode.Input.get!(10, 2021)
      |> String.split("\n", trim: true)

    result = part1(input)
    IO.inspect(result, label: "\n Answer d10p01")
    assert result == 167379
  end

  @tag :skip
  test "part2" do
    input =
      """
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      (((({<>}<{<{<>}{[]{[]{}
      {<[[]]>}<{[{[{[]{()[[[]
      <{([{{}}[<[[[<>{}]]]>[]]
      """
      |> String.split("\n", trim: true)

    result = part2(input)

    assert result == 288957
  end

  @tag :skip
  test "part2withInput" do
    input =
      AdventOfCode.Input.get!(10, 2021)
      |> String.split("\n", trim: true)

    result = part2(input)
    IO.inspect(result, label: "\n Answer d10p02")
    assert result == 2776842859
  end
end
