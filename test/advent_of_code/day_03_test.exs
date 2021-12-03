defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  @tag :skip
  test "part1" do
    input = 
"""
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""
    |> String.split("\n", trim: true)

    result = part1(input)

    assert result == 198
  end

  @tag :skip
  test "part1withInput" do
    input = AdventOfCode.Input.get!(3, 2021)
            |>String.split("\n", trim: true)
    result = part1(input)
    IO.inspect(result, label: "\n Answer d03p01")
  end

  @tag :skip
  test "part2" do
    input = 
"""
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""
    |> String.split("\n", trim: true)
    result = part2(input)

    assert result == 230
  end

  test "part2withInput" do
    AdventOfCode.Input.get!(3, 2021)
    |> String.split("\n", trim: true)
    |> part2()
    |> IO.inspect(label: "\n Answer d03p02")
  end
end
