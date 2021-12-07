defmodule AdventOfCode.Day07 do
  def part1(args) do
    max = Enum.max(args)
    min = Enum.min(args)
  
    Enum.map(min..max, fn pos ->
      Enum.map(args, fn crab_pos -> 
        :math.pow(pos - crab_pos, 2) 
        |> :math.sqrt()
        |> round() 
      end)
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.min()
  end

  def part2(args) do
    max = Enum.max(args)
    min = Enum.min(args)
  
    Enum.map(min..max, fn pos ->
      Enum.map(args, fn crab_pos -> 
        :math.pow(pos - crab_pos, 2) 
        |> :math.sqrt()
        |> round() 
        |> fibish()
      end)
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.min()
  end
  
  def fibish(0), do: 0
  def fibish(nr), do: fibish(nr - 1) + nr
end
