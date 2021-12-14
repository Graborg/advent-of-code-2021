defmodule AdventOfCode.Day14 do
  def double(x) do
    :timer.sleep(2000)
    x * 2
  end

  def get_rules_to_chunks_map(rules) do
    Enum.map(rules, fn rule -> String.split(rule, " -> ", trim: true) end)
    |> Enum.into(%{}, fn [key, val] ->
      [start, other] = String.split(key, "", trim: true)
      {[start, other], [[start, val], [val, other]]}
    end)
  end

  def part1([template | insertion_rules]) do
    temp_list = Enum.chunk_every(String.split(template, "", trim: true), 2, 1, :discard)

    values =
      insert_rules(
        temp_list,
        get_rules_to_chunks_map(insertion_rules),
        10
      )
      |> get_string_from_chunks()
      |> Enum.join()
      |> Kernel.<>(String.last(template))
      |> String.split("", trim: true)
      |> Enum.group_by(fn x -> x end)
      |> Map.values()
      |> Enum.map(&length/1)
      |> Enum.sort()
      |> IO.inspect()

    List.last(values) - List.first(values)
  end

  def get_string_from_chunks(chunks), do: Enum.map(chunks, fn [start, _other] -> start end)

  def pmap(collection, func) do
    {time_taken, res} =
      :timer.tc(fn ->
        collection
        |> Enum.map(&Task.async(fn -> func.(&1) end))
        |> Enum.flat_map(&Task.await/1)
      end)

    #   {time_taken, res} =
    #     :timer.tc(fn ->
    #       collection |> Enum.map(&func.(&1))
    #     end)

    IO.inspect(time_taken / 1_000_000, label: "add_chunks")
    res
  end

  def insert_rules(template, _rules, 0), do: template

  def insert_rules(temp_list, rules, count) do
    IO.inspect(count, label: "count")

    new_temp_list =
      temp_list
      |> pmap(fn chunk -> add_chunk(chunk, rules) end)

    insert_rules(new_temp_list, rules, count - 1)
  end

  def add_chunk([start, other], rules_to_chunks) when is_map_key(rules_to_chunks, [start, other]),
    do: Map.get(rules_to_chunks, [start, other])

  def part2([template | insertion_rules]) do
    temp_list = Enum.chunk_every(String.split(template, "", trim: true), 2, 1, :discard)

    values =
      insert_rules(
        temp_list,
        get_rules_to_chunks_map(insertion_rules),
        40
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
