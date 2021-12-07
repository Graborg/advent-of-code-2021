defmodule AdventOfCode.Day07 do
  def part1(args) do
    IO.inspect(args)
    max = Enum.max(args) |> IO.inspect
    min = Enum.min(args) |> IO.inspect
  
    Enum.map(min..max, fn pos ->
      Enum.map(args, fn crab_pos -> :math.sqrt(:math.pow(pos - crab_pos, 2))
    end)
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.min()
    |> round()
  end

  def part2(args) do
  end
end
