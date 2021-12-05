defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  test "part1" do
    input = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
  |> String.split("\n", trim: true)
    result = part1(input)

    assert result == 5
  end

  test "part1WithInput" do
    input = AdventOfCode.Input.get!(5, 2021)
    |> String.split("\n", trim: true)
    result = part1(input)

    IO.inspect(result, label: "\n Answer d05p01")
  end
  
  test "part1" do
    input = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
  |> String.split("\n", trim: true)
    result = part1(input)

    assert result == 5
  end
end
