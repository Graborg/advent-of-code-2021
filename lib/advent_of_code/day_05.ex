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

  def is_diagonal([x,y]), do: Enum.count(x) != 1 && Enum.count(y) != 1 

  def normalize(interval) do
    [first, second | _rest] = Enum.to_list(interval)
    if first > second, do: Enum.reverse(interval), else: interval
  end

  def is_negative_interval?(interval) do
    [first, second | _rest] = Enum.to_list(interval)
    first > second
  end
  
  def diagonal_stuff(map, [x,y]) do
    start_col = Enum.at(x, 0) |> IO.inspect(label: "start col")
    start_row = Enum.at(y, 0) |> IO.inspect(label: "start row")
    x_dir = if is_negative_interval?(x), do: -1, else: 1
    y_dir = if is_negative_interval?(y), do: -1, else: 1

    Enum.reduce(y, {map, start_row, start_col}, fn _, {acc_map, row_index, col_index} ->
        upd_map = List.update_at(acc_map, row_index, fn row -> List.update_at(row, col_index, fn value -> value + 1 end) end)   

        {upd_map, row_index + y_dir, col_index + x_dir}
    end) 
    |> elem(0)
  end 

  def part2(args) do
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
    |> Enum.reduce(map_of_lines, fn ([x, y], map) ->
      if is_diagonal([x,y]) do 
        diagonal_stuff(map, [x,y])
      else
        map
        |> Enum.with_index
        |> Enum.map(fn {row, row_nr} -> 
          if Enum.member?(y, row_nr) do 
            row 
            |> Enum.with_index() 
            |> Enum.map(fn {col, col_nr} -> 
              if Enum.member?(x, col_nr), do: col+1, else: col 
            end)
          else
            row
          end
        end)
      end
    end)
    |> IO.inspect
    |> count_dangerous()
  end
end
