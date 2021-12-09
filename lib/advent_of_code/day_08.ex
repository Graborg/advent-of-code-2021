defmodule AdventOfCode.Day08 do
  def part1(args) do
    args
    |> Enum.map(fn p -> 
      Enum.at(p, 1)
    end)
    |> IO.inspect
    |> Enum.concat()
      |> Enum.count(fn x -> Enum.member?([2,4,3,7], String.length(x)) end)  
  end

  def part2(args) do
    translation_maps = args
    |> Enum.map(fn %{input: i, output: o} -> i end)
    |> Enum.map(&get_translations/1)
    |> flip_maps()

    args
    |> Enum.map(fn %{output: o} -> o end)
    |> Enum.zip(translation_maps)
    |> Enum.map(fn {output, map} -> 
      Enum.map(output, fn number -> 
        Map.get(map, number) end)
    end)
    |> IO.inspect
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def flip_maps(maps) do
    Enum.map(maps, fn old_map -> 
      Enum.reduce(0..9, %{}, fn i, map -> 
        Map.get(old_map, i)
        |> permutate()
        |> Enum.reduce(map, fn permu, inner_map -> 
          Map.put(inner_map, permu, i) end)
      end)
    end)
  end

  def permutate(str) do
    String.split(str, "", trim: true)
    |> perms() 
    |> Enum.map(&Enum.join/1)
  end

  def perms([]), do: [[]]

  def perms(l) do
    for h <- l, t <- perms(l -- [h]),
      do: [h|t]
  end

  def get_translations(combinations) do
    p = Enum.group_by(combinations, &String.length/1)
    numbers_to_combos = %{
      1 => Map.get(p, 2) |> List.first(),
      4 => Map.get(p, 4) |> List.first(),
      7 => Map.get(p, 3) |> List.first(),
      8 => Map.get(p, 7) |> List.first(),
    }
    get_numbers_5(numbers_to_combos, Map.get(p, 5)) 
    |> get_numbers_6(Map.get(p, 6))
  end


  def get_shared_letters(combinations), do: 
    combinations 
    |> Enum.at(0)
    |> Enum.filter(fn letter -> 
        Enum.all?(combinations, fn other_combination -> 
          Enum.member?(other_combination, letter) 
        end) 
      end)

  def get_numbers_5(%{4 => combo_for_four} = map, five_letter_segments) do # 5 
    IO.inspect(five_letter_segments, label: "five letter segments")
    segments_as_lists = five_letter_segments
      |> Enum.map(fn x -> String.split(x, "", trim: true) end)
    disc_letters = Enum.map(segments_as_lists, fn combination -> 
        Enum.reject(combination, fn letter -> 
          Enum.member?(get_shared_letters(segments_as_lists), letter) 
      end) 
    end)
    disc_letters_with_index = Enum.with_index(disc_letters)

    three_index = disc_letters_with_index
      |> Enum.map(fn {[first, second] = letters, i} ->
        without_self = Enum.reject(disc_letters, fn other_letters -> 
          letters == other_letters || [second, first] == other_letters end)
        is_three = Enum.any?(without_self, fn other_letters -> 
          Enum.member?(other_letters, first) end) && Enum.any?(without_self, fn other_letters -> Enum.member?(other_letters,second) end)
        if is_three, do: i, else: nil
      end)
      |> Enum.find(fn index -> index end)

    two_index = disc_letters_with_index
      |> Enum.map(fn {letters, i} -> 
        if !Enum.all?(letters, fn l -> Enum.member?(String.split(combo_for_four, ""), l) end), do: i, else: nil
      end) 
      |> Enum.find(fn index -> index end)
    
    five_index = segments_as_lists 
                 |> Enum.with_index
      |> Enum.reject(fn {_, i} -> Enum.member?([three_index, two_index], i) end)
      |> Enum.at(0)
      |> elem(1)
      
   map 
     |> Map.put(3, Enum.at(five_letter_segments, three_index))
     |> Map.put(2, Enum.at(five_letter_segments, two_index))
     |> Map.put(5, Enum.at(five_letter_segments, five_index))
     |> IO.inspect
  end
  def get_numbers_6(%{1 => combo_for_one, 5 => combo_for_five} = map, combos) do 
    combinations = Enum.map(combos, fn x -> String.split(x, "", trim: true) end)
    
    disc_letters = Enum.map(combinations, fn combination -> 
      Enum.reject(combination, fn letter -> 
        Enum.member?(String.split(combo_for_five, "", trim: true), letter) 
      end) 
    end)
    zero_index = Enum.find_index(disc_letters, fn x -> Enum.count(x) == 2 end)
    nine_index = disc_letters 
    |> Enum.with_index
    |> Enum.reject(fn {_, i} -> i == zero_index end)
    |> Enum.find(fn {x, i} ->
      combo_for_one
      |> String.split("", trim: true)
      |> Enum.any?(fn l -> 
        Enum.member?(x, l) end)  
    end)
    |> elem(1)
  
    IO.inspect(nine_index, label: "nine_index")
    IO.inspect(zero_index, label: "zero_index")

    six_index = combinations
    |> Enum.with_index 
    |> Enum.reject(fn {_, i} -> Enum.member?([zero_index, nine_index], i) end)
    |> List.first()
    |> elem(1)
    |> IO.inspect(label: "sixindex")   
   map 
     |> Map.put(0, Enum.at(combos, zero_index))
     |> Map.put(9, Enum.at(combos, nine_index))
     |> Map.put(6, Enum.at(combos, six_index))
     |> IO.inspect(label: "the map")
  end
end
