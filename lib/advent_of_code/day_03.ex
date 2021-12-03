defmodule AdventOfCode.Day03 do
  def part1(args) do
    gamma_binary = get_gamma_binary(args)

    epsilon = gamma_binary 
    |> String.split("", trim: true) 
    |> Enum.map(&flip_binary/1)
    |> Enum.join() 
    |> integer_from_binary()

    gamma = integer_from_binary(gamma_binary)

    epsilon * gamma
  end

  def integer_from_binary(binary), do: Integer.parse(binary,2) |> elem(0)

  def get_gamma_binary(args) do
    lines = Enum.count(args)

    Enum.map(args, fn x -> String.split(x, "", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.zip_with(fn binary_numbers -> if Enum.sum(binary_numbers) >= lines/2, do: 1, else: 0 end)
    |> Enum.join()
  end

  def flip_binary("1"), do: "0"
  def flip_binary("0"), do: "1"

  def part2(args) do
    oxygen_rating = rec(args, 0, "oxygen") |> integer_from_binary() 
    c02_rating = rec(args, 0, "c02") |> integer_from_binary() 

    oxygen_rating * c02_rating
  end

  def rec([rating], _pos, _), do: rating
  def rec(args, position, "oxygen") do
    bit_value = get_gamma_binary(args) 
      |> String.at(position)  

    Enum.filter(args, fn x -> String.at(x, position) == bit_value end)
      |> rec(position + 1, "oxygen")
  end

  def rec(args, position, "c02") do
    bit_value = get_gamma_binary(args)
      |> String.at(position)
      |> flip_binary()

    Enum.filter(args, fn x -> String.at(x, position) == bit_value end)
      |> rec(position + 1, "c02")
  end
  
end
