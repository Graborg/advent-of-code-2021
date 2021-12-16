defmodule AdventOfCode.Day15 do
  def part1(args) do
    IO.inspect(args)
    go_down({0, 0}, args)
  end

  def go_down({x, y}, grid) do
    get_adjacent_do(
      x,
      y,
      Enum.count(grid),
      Enum.at(grid, 0) |> Enum.count(),
      grid,
      %{},
      0
    )
    |> IO.inspect()
  end

  def get_adjacent(row_nr, col_nr, nr_of_rows, nr_of_columns, grid, already_explored, count) do
    IO.inspect({row_nr, col_nr})
    IO.inspect(count)
    get_adjacent_do(row_nr, col_nr, nr_of_rows, nr_of_columns, grid, already_explored, count)
  end

  def get_adjacent_do(0, 0, _nr_of_columns, _nr_of_rows, grid, already_explored, count),
    do:
      [&get_right/5, &get_down/5]
      |> Enum.map(& &1.(grid, 0, 0, already_explored, count))

  # top right
  def get_adjacent_do(0, col_nr, _, nr_of_columns, grid, already_explored, count)
      when col_nr + 1 == nr_of_columns,
      do:
        [&get_left/5, &get_down/5]
        |> Enum.map(& &1.(grid, 0, col_nr, already_explored, count))

  # bottom left
  def get_adjacent_do(row_nr, 0, nr_of_rows, _, grid, already_explored, count)
      when row_nr + 1 == nr_of_rows,
      do:
        [&get_up/5, &get_right/5]
        |> Enum.map(& &1.(grid, row_nr, 0, already_explored, count))

  # bottom right
  def get_adjacent_do(row_nr, col_nr, nr_of_rows, nr_of_columns, grid, _, _count)
      when row_nr + 1 == nr_of_rows and col_nr + 1 == nr_of_columns,
      do: [
        Enum.at(grid, row_nr)
        |> Enum.at(col_nr)
      ]

  #### Four rows

  # top row
  def get_adjacent_do(0, col_nr, _, _, grid, already_explored, count),
    do:
      [&get_left/5, &get_right/5, &get_down/5]
      |> Enum.map(& &1.(grid, 0, col_nr, already_explored, count))

  # bottom row
  def get_adjacent_do(row_nr, col_nr, nr_of_rows, _, grid, already_explored, count)
      when row_nr + 1 == nr_of_rows,
      do:
        [&get_left/5, &get_right/5, &get_up/5]
        |> Enum.map(& &1.(grid, row_nr, col_nr, already_explored, count))

  # left side
  def get_adjacent_do(row_nr, 0, _, _, grid, already_explored, count),
    do:
      [&get_down/5, &get_right/5, &get_up/5]
      |> Enum.map(& &1.(grid, row_nr, 0, already_explored, count))

  # right side
  def get_adjacent_do(row_nr, col_nr, _, nr_of_columns, grid, already_explored, count)
      when col_nr + 1 == nr_of_columns,
      do:
        [&get_down/5, &get_left/5, &get_up/5]
        |> Enum.map(& &1.(grid, row_nr, col_nr, already_explored, count))

  #### The rest
  def get_adjacent_do(row_nr, col_nr, _, _, grid, already_explored, count),
    do:
      [&get_right/5, &get_down/5, &get_left/5, &get_up/5]
      |> Enum.map(& &1.(grid, row_nr, col_nr, already_explored, count))

  def get_left(_grid, _row_nr, _col_nr, _already_explored, count) when count > 50,
    do: 100_000_000_000_000

  def get_left(_grid, row_nr, col_nr, already_explored, _count)
      when is_map_key(already_explored, {row_nr, col_nr}),
      do: 100_000_000_000_000

  def get_left(grid, row_nr, col_nr, already_explored, count),
    do:
      Enum.at(grid, row_nr)
      |> Enum.at(col_nr - 1)
      |> (fn risk ->
            get_adjacent(
              row_nr,
              col_nr - 1,
              Enum.count(grid),
              Enum.at(grid, 0) |> Enum.count(),
              grid,
              Map.put(already_explored, {row_nr, col_nr}, true),
              count + 1
            )
            |> Enum.reject(fn x -> x >= 100_000_000_00000 end)
            |> Enum.map(&(&1 + risk))
          end).()

  def get_right(_grid, _row_nr, _col_nr, _already_explored, count) when count > 50,
    do: 100_000_000_000_000

  def get_right(_grid, row_nr, col_nr, already_explored, _count)
      when is_map_key(already_explored, {row_nr, col_nr}),
      do: 100_000_000_000_000

  def get_right(grid, row_nr, col_nr, already_explored, count),
    do:
      Enum.at(grid, row_nr)
      |> Enum.at(col_nr + 1)
      |> (fn risk ->
            get_adjacent(
              row_nr,
              col_nr + 1,
              Enum.count(grid),
              Enum.at(grid, 0) |> Enum.count(),
              grid,
              Map.put(already_explored, {row_nr, col_nr}, true),
              count + 1
            )
            |> Enum.reject(fn x -> x >= 100_000_000_00000 end)
            |> Enum.map(&(&1 + risk))
          end).()

  def get_up(_grid, _row_nr, _col_nr, _already_explored, count) when count > 50,
    do: 100_000_000_000_000

  def get_up(_grid, row_nr, col_nr, already_explored, _count)
      when is_map_key(already_explored, {row_nr, col_nr}),
      do: 100_000_000_000_000

  def get_up(grid, row_nr, col_nr, already_explored, count),
    do:
      Enum.at(grid, row_nr - 1)
      |> Enum.at(col_nr)
      |> (fn risk ->
            get_adjacent(
              row_nr - 1,
              col_nr,
              Enum.count(grid),
              Enum.at(grid, 0) |> Enum.count(),
              grid,
              Map.put(already_explored, {row_nr, col_nr}, true),
              count + 1
            )
            |> Enum.reject(fn x -> x >= 100_000_000_00000 end)
            |> Enum.map(&(&1 + risk))
          end).()

  def get_down(_grid, _row_nr, _col_nr, _already_explored, count) when count > 50,
    do: 100_000_000_000_000

  def get_down(_grid, row_nr, col_nr, already_explored, _count)
      when is_map_key(already_explored, {row_nr, col_nr}),
      do: 100_000_000_000_000

  def get_down(grid, row_nr, col_nr, already_explored, count),
    do:
      Enum.at(grid, row_nr + 1)
      |> Enum.at(col_nr)
      |> (fn risk ->
            get_adjacent(
              row_nr + 1,
              col_nr,
              Enum.count(grid),
              Enum.at(grid, 0) |> Enum.count(),
              grid,
              Map.put(already_explored, {row_nr, col_nr}, true),
              count + 1
            )
            |> Enum.reject(fn x -> x >= 100_000_000_00000 end)
            |> Enum.map(&(&1 + risk))
          end).()

  def add_adj_to_list(new_adjacent, adjacents), do: adjacents ++ [new_adjacent]

  def part2(args) do
  end
end
