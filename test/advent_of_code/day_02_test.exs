defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  @tag :skip
  test "part1" do
    input = """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
    {hpos, dpos} = part1(input)
            |> IO.inspect()
    result = hpos * dpos
    assert result == 150 
  end

  @tag :skip
  test "part1withInput" do
    input = AdventOfCode.Input.get!(2, 2021)
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
    {hpos, dpos} = part1(input)
    result = hpos * dpos
    IO.inspect(result, label: "\n Answer d02p01")
  end

  @tag :skip
  test "part2" do
    input = """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
    {hpos, dpos, _aim} = part2(input)
            |> IO.inspect()
    result = hpos * dpos
    assert result == 900 
  end

  test "part2withInput" do
    input = AdventOfCode.Input.get!(2, 2021)
            |>String.split("\n", trim: true)
            |>Enum.map(&String.trim/1)
    {hpos, dpos, _aim} = part2(input)
    result = hpos * dpos
    IO.inspect(result, label: "\n Answer d02p01")
  end
end
