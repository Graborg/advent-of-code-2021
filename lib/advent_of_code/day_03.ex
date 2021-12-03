defmodule AdventOfCode.Day03 do
  def part1(args) do
    lines = Enum.count(args)
    
    gamma_binary = Enum.map(args, fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.zip_with(fn binary_numbers -> 
        if (Enum.sum(binary_numbers) > lines/2) do 
          1 
        else
          0
        end
      end)
    |> Enum.join()

    epsilon = gamma_binary 
    |> String.split("", trim: true) 
    |> Enum.map(&flip_binary/1)
    |> Enum.join() 
    |> Integer.parse(2)
    |> elem(0)

    gamma = gamma_binary
    |> Integer.parse(2)
    |> elem(0)

    epsilon * gamma
  end

  def flip_binary("1"), do: "0"
  def flip_binary("0"), do: "1"

  def part2(args) do
  end
end
