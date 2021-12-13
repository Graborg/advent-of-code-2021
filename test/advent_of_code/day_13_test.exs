defmodule AdventOfCode.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Day13

  @tag :skip
  test "part1" do
    input =
      """
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5
      """
      |> String.split("\n", trim: true)
      |> IO.inspect()

    result = part1(input)

    assert result == 17
  end

  @tag :skip
  test "part1withInput" do
    input =
      AdventOfCode.Input.get!(13, 2021)
      |> String.split("\n", trim: true)

    result = part1(input)
    IO.inspect(result, label: "\n Answer d13p01")
    # assert result == 
  end

  test "part2withInput" do
    input =
      AdventOfCode.Input.get!(13, 2021)
      |> String.split("\n", trim: true)

    result = part1(input)
    # IO.inspect(result, label: "\n Answer d13p02")
    # assert result == 
  end
end
