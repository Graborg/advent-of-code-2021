defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09

  @tag :skip
  test "part1" do
    input = 
"""
2199943210
3987894921
9856789892
8767896789
9899965678
"""
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, "", trim: true) end)
    result = part1(input)

    assert result == 15
  end

  @tag :skip
  test "part1withInput" do
    input = AdventOfCode.Input.get!(9, 2021)
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, "", trim: true) end)
    result = part1(input)
    IO.inspect(result, label: "\n Answer d09p01")
  end

  @tag :skip
  test "part2" do
    input = 
"""
2199943210
3987894921
9856789892
8767896789
9899965678
"""
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, "", trim: true) end)
    result = part2(input)

    assert result == 1134
  end

  @tag :skip
  test "part2withInput" do
    input = AdventOfCode.Input.get!(9, 2021)
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, "", trim: true) end)
    result = part2(input)
    IO.inspect(result, label: "\n Answer d09p02")
  end
end
