defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  @tag :skip
  test "part1" do
    input = "3,4,3,1,2"
|> String.split(",")
|> Enum.map(&String.to_integer/1)
|> IO.inspect()
    result = part1(input)

    assert result == 5934
  end

  @tag :skip
  test "part1withInput" do
    input = AdventOfCode.Input.get!(6, 2021)
            |> String.split(",")
            |> Enum.map(&String.trim/1)
            |> Enum.map(&String.to_integer/1)
    result = part1(input)
    IO.inspect(result, label: "\n Answer d06p01")
  end


  @tag :skip
  test "part2" do
    input = "3,4,3,1,2"
|> String.split(",")
|> Enum.map(&String.to_integer/1)
|> IO.inspect()
    result = part2(input)

    assert result == 26984457539
  end

  @tag :skip
  test "part2withInput" do
    input = AdventOfCode.Input.get!(6, 2021)
            |> String.split(",")
            |> Enum.map(&String.trim/1)
            |> Enum.map(&String.to_integer/1)
    result = part2(input)
    IO.inspect(result, label: "\n Answer d06p02")
  end
end
