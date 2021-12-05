defmodule AdventOfCode.Day05 do
  def part1(args) do
    map_of_lines = List.duplicate([], 1000)
    |> Enum.map(fn x -> List.duplicate(0, 1000) end)
    args
    |> Enum.map(fn x -> String.split(x, [" -> "]) end)
    |> Enum.map(fn x -> 
      Enum.map(x, fn coord -> String.split(coord, ",") end)
      |> Enum.zip_with(fn vec -> 
        [first, last] = Enum.map(vec, &String.to_integer/1) 
        first..last
      end)
    end)
    |> Enum.filter(fn [x, y] -> Enum.count(x) == 1 || Enum.count(y) == 1 end) 
    |> Enum.reduce(map_of_lines, fn ([x, y], map) ->
      map
      |> Enum.with_index
      |> Enum.map(fn {row, row_nr} -> 
        if Enum.member?(y, row_nr) do 
          row 
          |> Enum.with_index() 
          |> Enum.map(fn {col, col_nr} -> if Enum.member?(x, col_nr), do: col+1, else: col end)
        else
          row
        end
      end)
    end)
    |> count_dangerous()
  end

  def count_dangerous(map) do
    Enum.reduce(map, 0, fn row, acc -> 
      acc + Enum.count(row, fn value -> value >= 2 end) 
    end)
  end

  def part2(args) do
  end
end
