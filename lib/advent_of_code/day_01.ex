defmodule AdventOfCode.Day01 do
  def part1(args) do
    Enum.map_reduce(args, 0, fn x, prev -> {x > prev, x} end)
    |> elem(0)
    |> tl()
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end

  def part2(args) do

    Enum.map_reduce(args, [], &part2_reducer/2) 
    |> elem(0)
    |> tl()
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end

  def part2_reducer(x, [_first, second, third] = old_win) do
      new_win = [second, third, x] 
    {Enum.sum(new_win) > Enum.sum(old_win), new_win}
  end

  def part2_reducer(x, old_win), do: {false, old_win ++ [x]} 

end
