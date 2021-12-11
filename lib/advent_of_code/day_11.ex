defmodule AdventOfCode.Day11 do
  def part1(args) do
    rec(args)
  end

  def pop_on_index({grid, prev_popped}, row_nr, col_nr) do
    case {row_nr, col_nr} in prev_popped do
      true -> 
        {List.update_at(grid, row_nr, fn row -> List.update_at(row, col_nr, fn _ -> 0 end) end), prev_popped}
      false ->
        {List.update_at(grid, row_nr, fn row -> List.update_at(row, col_nr, &inc/1) end), prev_popped}
    end
  end

  def pop_left({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr, col_nr - 1)

  def pop_right({grid, prev_popped},row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr, col_nr + 1)

  def pop_up({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr - 1, col_nr) 

  def pop_up_left({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr - 1, col_nr - 1) 

  def pop_up_right({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr - 1, col_nr + 1) 

  def pop_down({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr + 1, col_nr)

  def pop_down_left({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr + 1, col_nr - 1)

  def pop_down_right({grid, prev_popped}, row_nr, col_nr),
    do: pop_on_index({grid, prev_popped}, row_nr + 1, col_nr + 1)

  def inc(x), do: x + 1

  def rec(grid), do: rec({grid, 0}, 1)
  def rec({_grid, pops}, 101), do: pops

  def rec({grid, pops}, count) do
    {new_grid, nr_pops} = increase_all(grid)
      |> make_em_pop([])
      |> set_poppers_to_zero()
    rec({new_grid, nr_pops + pops}, count + 1)
  end

  def set_poppers_to_zero({grid, popped}), do: 
  {Enum.map(grid, fn row -> 
    Enum.map(row, fn col -> if col > 9, do: 0, else: col end) 
  end), popped}

  def increase_all(grid) do
    Enum.map(grid, fn row -> Enum.map(row, &inc/1) end)
  end

  def make_em_pop(grid, prev_pops) do
   # IO.inspect(prev_pops, label: "prev pops")
    new_poppers = 
      grid
      |> Enum.with_index()
      |> Enum.map(fn {row, row_nr} ->
        row
        |> Enum.with_index()
        |> Enum.filter(fn {value, _} -> value > 9 end)
        |> Enum.reject(fn {_, col_nr} -> {row_nr, col_nr} in prev_pops end)
        |> Enum.map(fn {_, i} -> i end)
    end)
    |> Enum.with_index()
    |> Enum.flat_map(fn {col_nrs, row_nr} -> 
      Enum.map(col_nrs, fn col_nr -> {row_nr, col_nr} end) 
    end)
    all_poppers = prev_pops ++ new_poppers
    if Enum.count(new_poppers) > 0 do
      grid_after_pop = new_poppers
      |> Enum.reduce(grid, fn {popped_row_nr, popped_col_nr}, temp_grid ->
        {grid, _} =  pop_adjacent(
            popped_row_nr,
            popped_col_nr,
            Enum.count(grid),
            Enum.count(Enum.at(grid, 0)),
            {temp_grid, all_poppers}
        )
        grid
      end)
      |> make_em_pop(all_poppers)
    else
      {grid, Enum.count(prev_pops)}
    end
  end
  
  # top left
  def pop_adjacent(0, 0, _, _, {grid, prev_popped}),
  do: pop_right({grid, prev_popped}, 0, 0)|> pop_down(0, 0) |> pop_down_right(0, 0)

  # top right
  def pop_adjacent(0, col_nr, _, nr_of_columns, {grid, prev_popped})
      when col_nr + 1 == nr_of_columns,
      do: pop_left({grid, prev_popped}, 0, col_nr) |> pop_down(0, col_nr) |> pop_down_left(0, col_nr)

  # bottom left
  def pop_adjacent(row_nr, 0, nr_of_rows, _, {grid, prev_popped}) when row_nr + 1 == nr_of_rows,
  do: pop_up({grid, prev_popped}, row_nr, 0) |> pop_right(row_nr, 0) |> pop_up_right(row_nr, 0)

  # bottom right
  def pop_adjacent(row_nr, col_nr, nr_of_rows, nr_of_columns, {grid, prev_popped})
      when row_nr + 1 == nr_of_rows and col_nr + 1 == nr_of_columns,
      do:
        pop_left({grid, prev_popped}, row_nr, col_nr)
        |> pop_up(row_nr, col_nr)
        |> pop_up_left(row_nr, col_nr)

  #### Four sides

  # top row
  def pop_adjacent(0, col_nr, _, _, {grid, prev_popped}), do:
    pop_left({grid, prev_popped}, 0, col_nr)
    |> pop_right(0, col_nr)
    |> pop_down(0, col_nr)
    |> pop_down_left(0, col_nr)
    |> pop_down_right(0, col_nr)

  # bottom row
  def pop_adjacent(row_nr, col_nr, nr_of_rows, _, {grid, prev_popped})
      when row_nr + 1 == nr_of_rows,
      do:
        pop_left({grid, prev_popped}, row_nr, col_nr)
        |> pop_up(row_nr, col_nr)
        |> pop_right(row_nr, col_nr)
        |> pop_up_left(row_nr, col_nr)
        |> pop_up_right(row_nr, col_nr)

  # left side
  def pop_adjacent(row_nr, 0, _, _, {grid, prev_popped}),
    do:
      pop_up({grid, prev_popped}, row_nr, 0)
      |> pop_right(row_nr, 0)
      |> pop_down(row_nr, 0)
      |> pop_down_right(row_nr, 0)
      |> pop_up_right(row_nr, 0)

  # right side
  def pop_adjacent(row_nr, col_nr, _, nr_of_columns, {grid, prev_popped})
      when col_nr + 1 == nr_of_columns,
      do:
        pop_left({grid, prev_popped}, row_nr, col_nr)
        |> pop_up(row_nr, col_nr)
        |> pop_down(row_nr, col_nr)
        |> pop_down_left(row_nr, col_nr)
        |> pop_up_left(row_nr, col_nr)

  #### The rest
  def pop_adjacent(row_nr, col_nr, _, _, {grid, prev_popped}),
    do:
      pop_left({grid, prev_popped}, row_nr, col_nr)
      |> pop_up(row_nr, col_nr)
      |> pop_right(row_nr, col_nr)
      |> pop_down(row_nr, col_nr)
      |> pop_down_right(row_nr, col_nr)
      |> pop_down_left(row_nr, col_nr)
      |> pop_up_left(row_nr, col_nr)
      |> pop_up_right(row_nr, col_nr)

  def part2(args) do
  end
end
