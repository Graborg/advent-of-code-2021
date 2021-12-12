defmodule AdventOfCode.Day12 do
  def part1(args) do
    get_path("start", args, ["start"])
    |> IO.inspect()
    |> Enum.count(fn x -> x == "end" end)
  end

  def part2(args) do
    get_path("start", args, ["start"])
    |> IO.inspect(label: "fin")
    |> Enum.count(fn x -> x == "end" end)
  end


  def get_path("end", _entries, path), do: path
  def get_path(dest, entries, path) do
    Enum.filter(entries, fn entry -> 
      [start, new_dest] = String.split(entry, "-") 
      new_dest == dest || start == dest
    end)
    |> Enum.map(fn entry -> 
      String.split(entry, "-") 
                 |> Enum.reject(fn x -> x == dest end)
                 |> List.first()
    end)
    |> Enum.reject(fn new_node -> is_visited_small_cave?(new_node, path) end)
    |> Enum.map(fn new_node -> get_path(new_node, entries, path ++ [new_node]) end)
    |> Enum.reject(&Enum.empty?/1)
    |> Enum.flat_map(fn x -> x end)

  end
def is_visited_small_cave?("start", []), do: false
def is_visited_small_cave?("start", _path), do: true
def is_visited_small_cave?(new_node, path) do
  duplicates = path -- Enum.uniq(path) |> Enum.filter(fn x -> String.downcase(x) == x end)
  if String.downcase(new_node) == new_node && Enum.count(duplicates) > 0 do 
    new_node == Enum.at(duplicates, 0) || Enum.member?(path, new_node)
  else 
    false
  end
end
end
