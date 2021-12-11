defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  @tag :skip
  test "part1" do
    input = 
  """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)
    result = part1(input)

    assert result == 1656
  end

  test "part1withInput" do
    input =
      AdventOfCode.Input.get!(11, 2021)
        |> String.split("\n", trim: true)
        |> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)

    result = part1(input)
    IO.inspect(result, label: "\n Answer d11p01")
    assert result == 1546
  end

  @tag :skip
  test "part2" do
    input = 
  """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)
    result = part2(input)

    assert result == 195
  end

  test "part2withInput" do
    input =
      AdventOfCode.Input.get!(11, 2021)
        |> String.split("\n", trim: true)
        |> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)

    result = part2(input)
    IO.inspect(result, label: "\n Answer d11p02")
    assert result == 471
  end
end
