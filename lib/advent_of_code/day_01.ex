defmodule AdventOfCode.Day01 do
  def part1(args) do
    Enum.map_reduce(args, 0, fn x, prev -> {x > prev, x} end)
    |> elem(0)
    |> tl()
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end

  def part2(args) do
  end
end
