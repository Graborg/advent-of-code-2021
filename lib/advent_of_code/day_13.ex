defmodule AdventOfCode.Day13 do
  def part1(args) do
    folds = Enum.filter(args, fn x -> String.starts_with?(x, "fold") end)
    |> Enum.map(fn "fold along " <> fold -> [axis, index] = String.split(fold, "=") 
    {axis, String.to_integer(index)}
    end)
    |> List.first()
    |> IO.inspect()

    Enum.reject(args, fn x -> String.starts_with?(x, "fold") end)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> IO.inspect()
    |> put_on_map(folds)
    |> Enum.filter(fn [x, y] -> x < folds end)
    |> Enum.uniq()
    |> IO.inspect(label: "done")
    |> Enum.count()
    |> IO.inspect(label: "done")
  end

  def put_on_map(dots, first_fold) do
    Enum.map(dots, fn ([x, y]) -> j(x,y, first_fold) end)  
    end
  
  def j(x,y, {"y", index}) when y > index, do:
    [x,index - (y - index)]  

  def j(x,y, {"x", index}) when x > index, do:
    [index - (x - index),y]  
  def j(x,y, {_, _}), do: [x,y]  

  def part2(args) do
  end
end
