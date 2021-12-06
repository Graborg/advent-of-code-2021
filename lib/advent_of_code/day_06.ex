defmodule AdventOfCode.Day06 do
  def part1(args) do
    days = 80 
    Enum.reduce(1..days, args, fn day, fishes ->
      updated_fishes = Enum.map(fishes, fn fish -> fish - 1 end)

      nr_newborn = Enum.count(updated_fishes, fn fish -> fish == -1 end)
      new_fishes = List.duplicate(8, nr_newborn)
      
      updated_fishes = Enum.map(updated_fishes, fn fish ->
        if fish == -1, do: 6, else: fish
      end) 
      updated_fishes ++ new_fishes
    end)
    |> Enum.count
  end

  def part2(args) do
    days = 256

    fish_list = List.duplicate(0, 9) 
      |> Enum.with_index
      |> Enum.map(fn {_, i} -> 
        Enum.count(args, fn x -> x == i end) 
      end)

    Enum.reduce(1..days, fish_list, fn day, fishes -> 
      [zeroes | rest] = fishes
      rest
      |> List.update_at(6, fn old_sevens -> zeroes + old_sevens end)
      |> List.insert_at(8, zeroes)
    end)
    |> Enum.sum
  end
end
