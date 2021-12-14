defmodule AdventOfCode.Day14 do
  def part1([template | insertion_rules]) do
    temp_list = Enum.chunk_every(String.split(template, "", trim: true), 2, 1, :discard)

    values =
      insert_rules(
        temp_list,
        Enum.map(insertion_rules, fn rule -> String.split(rule, " -> ", trim: true) end),
        10,
        %{}
      )
      |> get_string_from_chunks()
      |> Enum.join()
      |> Kernel.<>(String.last(template))
      |> IO.inspect()
      |> String.split("", trim: true)
      |> Enum.group_by(fn x -> x end)
      |> Map.values()
      |> Enum.map(&length/1)
      |> Enum.sort()
      |> IO.inspect()

    List.last(values) - List.first(values)
  end

  def get_string_from_chunks(chunks) do
    Enum.map(chunks, fn [start, _other] -> start end)
  end

  def insert_rules(template, _rules, 0, _), do: template

  def insert_rules(temp_list, rules, count, map) do
    IO.inspect(Enum.join(temp_list))
    IO.inspect(count, label: "count")

    {new_temp_list, new_map} =
      temp_list
      |> IO.inspect(label: "chinked")
      |> Enum.reduce({[], map}, fn [start, other], {acc_list, temp_map} ->
        if Map.has_key?(temp_map, [start, other]) do
          new = Map.get(temp_map, [start, other])
          {acc_list ++ [[start, new], [new, other]], temp_map}
        else
          [_, new] =
            Enum.find(rules, fn [from, _] ->
              String.starts_with?(from, start <> other)
            end)

          {acc_list ++ [[start, new], [new, other]], Map.put_new(temp_map, [start, other], new)}
        end
      end)

    insert_rules(new_temp_list, rules, count - 1, new_map)
  end

  def part21([template | insertion_rules]) do
    values =
      insert_rules(
        template,
        Enum.map(insertion_rules, fn rule -> String.split(rule, " -> ", trim: true) end),
        40,
        %{}
      )
      |> String.split("", trim: true)
      |> Enum.group_by(fn x -> x end)
      |> Map.values()
      |> Enum.map(&length/1)
      |> Enum.sort()
      |> IO.inspect()

    List.last(values) - List.first(values)
  end

  def part2([template | insertion_rules]) do
    temp_list = Enum.chunk_every(String.split(template, "", trim: true), 2, 1, :discard)

    values =
      insert_rules(
        temp_list,
        Enum.map(insertion_rules, fn rule -> String.split(rule, " -> ", trim: true) end),
        40,
        %{}
      )
      |> get_string_from_chunks()
      |> Enum.join()
      |> Kernel.<>(String.last(template))
      |> IO.inspect()
      |> String.split("", trim: true)
      |> Enum.group_by(fn x -> x end)
      |> Map.values()
      |> Enum.map(&length/1)
      |> Enum.sort()
      |> IO.inspect()

    List.last(values) - List.first(values)
  end
end
