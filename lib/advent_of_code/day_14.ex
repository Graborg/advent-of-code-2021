defmodule AdventOfCode.Day14 do
  def get_rules_to_chunks_map(rules) do
    Enum.map(rules, fn rule -> String.split(rule, " -> ", trim: true) end)
    |> Enum.into(%{}, fn [key, val] ->
      [start, other] = String.split(key, "", trim: true)
      {[start, other], [[start, val], [val, other]]}
    end)
  end

  def part1([template | insertion_rules]) do
    chunks = Enum.chunk_every(String.split(template, "", trim: true), 2, 1, :discard)

    chunks_list = chunks |> Enum.uniq()

    values =
      insert_rules(
        chunks
        |> Enum.map(fn chunk ->
          Integer.to_string(Enum.find_index(chunks_list, fn x -> x == chunk end))
        end),
        get_rules_to_chunks_map(insertion_rules),
        10,
        chunks_list
      )
      |> get_string_from_chunk_indices()
      |> get_string_from_chunks
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

  def get_string_from_chunk_indices({chunks, mapping_list}),
    do: Enum.map(chunks, fn chunk_i -> Enum.at(mapping_list, String.to_integer(chunk_i)) end)

  def get_string_from_chunks(chunks), do: Enum.map(chunks, fn [start, _other] -> start end)

  def insert_rules(chunks, _rules, 0, mapping_list), do: {chunks, mapping_list}

  def insert_rules(chunks, rules, count, chunk_mapping_list) do
    IO.inspect(count, label: "count")

    {new_chuncks_in_nrs, chunk_mapping_list} =
      chunks
      |> Enum.uniq()
      |> Enum.map(fn chunk_index ->
        {chunk_index, Enum.at(chunk_mapping_list, String.to_integer(chunk_index))}
      end)
      |> Enum.reduce({chunks, chunk_mapping_list}, fn {index, chunk},
                                                      {res_chunks_list, temp_map_list} ->
        {indices, new_temp_chunk_list} =
          get_chunks_from_chunk(chunk, rules)
          |> Enum.reduce({[], temp_map_list}, fn chunk,
                                                 {chunk_map_incides, inner_tmp_chunk_list} ->
            chunk_index = Enum.find_index(inner_tmp_chunk_list, &(&1 == chunk))

            if !is_nil(chunk_index) do
              {chunk_map_incides ++ [chunk_index], inner_tmp_chunk_list}
            else
              chunk_i = Enum.count(inner_tmp_chunk_list)

              upd_list = List.insert_at(inner_tmp_chunk_list, chunk_i, chunk)

              {chunk_map_incides ++ [chunk_i], upd_list}
            end
          end)

        res_list =
          res_chunks_list
          |> Enum.with_index()
          |> Enum.filter(fn {x, _i} -> x == index end)
          |> Enum.map(fn {_, i} -> i end)
          |> Enum.with_index()
          |> Enum.reduce(res_chunks_list, fn {chunk_index, offset}, res_list ->
            res_list
            |> List.delete_at(chunk_index + offset)
            |> List.insert_at(chunk_index + offset, Enum.at(indices, 0))
            |> List.insert_at(chunk_index + 1 + offset, Enum.at(indices, 1))
          end)

        {res_list, new_temp_chunk_list}
      end)

    new_chuncks_in_nrs
    |> Enum.map(fn x -> Integer.to_string(x) end)
    |> insert_rules(rules, count - 1, chunk_mapping_list)
  end

  def get_chunks_from_chunk([start, other], rules_to_chunks)
      when is_map_key(rules_to_chunks, [start, other]),
      do: Map.get(rules_to_chunks, [start, other])

  def part2([template | insertion_rules]) do
    chunks = Enum.chunk_every(String.split(template, "", trim: true), 2, 1, :discard)

    chunks_list = chunks |> Enum.uniq()

    values =
      insert_rules(
        chunks
        |> Enum.map(fn chunk ->
          Integer.to_string(Enum.find_index(chunks_list, fn x -> x == chunk end))
        end),
        get_rules_to_chunks_map(insertion_rules),
        40,
        chunks_list
      )
      |> get_string_from_chunk_indices()
      |> get_string_from_chunks
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
end
