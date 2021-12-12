defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @tag :skip
  test "part1" do
    input = """
            199 
            200 
            208
            210
            200
            207
            240
            269
            260
            263
            """
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
            |>Enum.map(&String.to_integer/1)
    result = part1(input)
    assert result == 7
  end

  @tag :skip
  test "part1withInput" do
   AdventOfCode.Input.get!(1, 2021)
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
            |>Enum.map(&String.to_integer/1)
            |>part1()
            |>IO.inspect(label: "\n Answer d01p01")
  end

  @tag :skip
  test "part2" do
    input = """
            199 
            200 
            208
            210
            200
            207
            240
            269
            260
            263
            """
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
            |>Enum.map(&String.to_integer/1)
    result = part2(input)

    assert result == 5
  end

  @tag :skip
  test "part2withInput" do
   AdventOfCode.Input.get!(1, 2021)
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
            |>Enum.map(&String.to_integer/1)
            |>part2()
            |>IO.inspect(label: "\n Answer d01p02")
  end
end
