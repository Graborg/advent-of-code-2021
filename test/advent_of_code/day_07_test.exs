defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  @tag :skip
  test "part1" do
    input = "16,1,2,0,4,2,7,1,2,14"
            |> String.split(",", trim: true)
            |> Enum.map(&String.to_integer/1)
    result = part1(input)

    assert result == 37
  end

  test "part1withInput" do
    input = AdventOfCode.Input.get!(7, 2021)
            |> String.split(",", trim: true)
            |> Enum.map(&String.trim/1)
            |> Enum.map(&String.to_integer/1)
    result = part1(input)
    IO.inspect(result, label: "\n Answer d07p01")
  end
  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
