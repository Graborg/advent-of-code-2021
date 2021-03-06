defmodule AdventOfCode.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Day15

  @tag :skip
  test "part1" do
    input =
      """
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)

    result = part1(input)

    assert result == 40
  end

  @tag :skip
  test "part1withInput" do
    input =
      AdventOfCode.Input.get!(15, 2021)
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)

    result = part1(input)
    IO.inspect(result, label: "\n Answer d15p01")
    assert result == 527
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
