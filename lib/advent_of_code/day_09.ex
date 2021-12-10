defmodule AdventOfCode.Day09 do
  def part1(args) do
    args
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_nr} ->
      Enum.with_index(row)
      |> Enum.filter(fn {p, col_nr} ->

        min_adjacent =
          get_adjacent(row_nr, col_nr, Enum.count(args), Enum.count(row), args)
          |> Enum.min()

        p < min_adjacent
      end)
    end)
    |> Enum.map(fn {value, _} -> String.to_integer(value) + 1 end)
    |> Enum.sum()
  end

  def add_adj_to_list(new_adjacent, adjacents), do: adjacents ++ [new_adjacent]

  #### Four corners
  # top left
  def get_adjacent(0, 0, _, _, grid),
    do: [nil, nil] |> get_right(grid, 0, 0) |> get_down(grid, 0, 0)

  # top right
  def get_adjacent(0, col_nr, _, nr_of_columns, grid) when col_nr + 1 == nr_of_columns,
    do: get_left(grid, 0, col_nr) |> Enum.concat([nil, nil]) |> get_down(grid, 0, col_nr)

  # bottom left
  def get_adjacent(row_nr, 0, nr_of_rows, _, grid) when row_nr + 1 == nr_of_rows,
    do: [nil] |> get_up(grid, row_nr, 0) |> get_right(grid, row_nr, 0) |> Enum.concat([nil])

  # bottom right
  def get_adjacent(row_nr, col_nr, nr_of_rows, nr_of_columns, grid)
      when row_nr + 1 == nr_of_rows and col_nr + 1 == nr_of_columns,
      do:
        get_left(grid, row_nr, col_nr)
        |> get_up(grid, row_nr, col_nr)
        |> Enum.concat([nil])
        |> Enum.concat([nil])

  #### Four rows

  # top row
  def get_adjacent(0, col_nr, _, _, grid),
    do:
      get_left(grid, 0, col_nr)
      |> Enum.concat([nil])
      |> get_right(grid, 0, col_nr)
      |> get_down(grid, 0, col_nr)

  # bottom row
  def get_adjacent(row_nr, col_nr, nr_of_rows, _, grid) when row_nr + 1 == nr_of_rows,
    do:
      get_left(grid, row_nr, col_nr)
      |> get_up(grid, row_nr, col_nr)
      |> get_right(grid, row_nr, col_nr)
      |> Enum.concat([nil])

  # left side
  def get_adjacent(row_nr, 0, _, _, grid),
    do:
      [nil] |> get_up(grid, row_nr, 0) |> get_right(grid, row_nr, 0) |> get_down(grid, row_nr, 0)

  # right side
  def get_adjacent(row_nr, col_nr, _, nr_of_columns, grid) when col_nr + 1 == nr_of_columns,
    do:
      get_left(grid, row_nr, col_nr)
      |> get_up(grid, row_nr, col_nr)
      |> Enum.concat([nil])
      |> get_down(grid, row_nr, col_nr)

  #### The rest
  def get_adjacent(row_nr, col_nr, _, _, grid),
    do:
      get_left(grid, row_nr, col_nr)
      |> get_up(grid, row_nr, col_nr)
      |> get_right(grid, row_nr, col_nr)
      |> get_down(grid, row_nr, col_nr)

  def get_left(adjacents \\ [], grid, row_nr, col_nr),
    do:
      Enum.at(grid, row_nr)
      |> Enum.at(col_nr - 1)
      |> add_adj_to_list(adjacents)

  def get_right(adjacents \\ [], grid, row_nr, col_nr),
    do:
      Enum.at(grid, row_nr)
      |> Enum.at(col_nr + 1)
      |> add_adj_to_list(adjacents)

  def get_up(adjacents \\ [], grid, row_nr, col_nr),
    do:
      Enum.at(grid, row_nr - 1)
      |> Enum.at(col_nr)
      |> add_adj_to_list(adjacents)

  def get_down(adjacents \\ [], grid, row_nr, col_nr),
    do:
      Enum.at(grid, row_nr + 1)
      |> Enum.at(col_nr)
      |> add_adj_to_list(adjacents)

  def part2(args) do
    IO.inspect(args)

    basin_starts =
      args
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, row_nr} ->
        Enum.with_index(row)
        |> Enum.filter(fn {p, col_nr} ->
          min_adjacent =
            get_adjacent(row_nr, col_nr, Enum.count(args), Enum.count(row), args)
            |> Enum.reject(&is_nil/1)
            |> Enum.min()

          p < min_adjacent
        end)
        |> Enum.map(fn {p, col_nr} -> {row_nr, col_nr} end)
      end)
      |> IO.inspect()

    basin_starts
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn basin -> get_complete_basin(args, basin) end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  def get_complete_basin(grid, {row_nr, col_nr}) do
    IO.inspect("new")
    start = Enum.at(grid, row_nr) |> Enum.at(col_nr)
    cont(start, row_nr, col_nr, grid, []) |> elem(0)
  end

  def cont(nil, _, _, _, v), do: {0, v}
  def cont("9", _, _, _, v), do: {0, v}

  def cont(value, row_nr, col_nr, grid, visited) do
    current_pos = {row_nr, col_nr}

    if !Enum.member?(visited, current_pos) do
      [left, up, right, down] =
        get_adjacent(row_nr, col_nr, Enum.count(grid), Enum.at(grid, 0) |> Enum.count(), grid)

      visited = [current_pos] ++ visited

      {left_path, visited_new} = cont(left, row_nr, col_nr - 1, grid, visited)
      {up_path, visited_new} = cont(up, row_nr - 1, col_nr, grid, visited_new)
      {right_path, visited_new} = cont(right, row_nr, col_nr + 1, grid, visited_new)
      {down_path, visited_new} = cont(down, row_nr + 1, col_nr, grid, visited_new)

      {left_path + up_path + right_path + down_path + 1, visited_new}
    else
      {0, visited}
    end
  end
end
