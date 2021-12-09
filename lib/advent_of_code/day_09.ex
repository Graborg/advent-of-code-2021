defmodule AdventOfCode.Day09 do
  def part1(args) do
    IO.inspect(args)
    args
    |> Enum.with_index
    |> Enum.flat_map(fn {row, row_nr} -> 
      Enum.with_index(row)
      |> Enum.filter(fn {p, col_nr} ->
        IO.inspect(p, label: "value")
        min_adjacent = get_adjacent(row_nr, col_nr, Enum.count(args), Enum.count(row), args)
                       |> IO.inspect(label: "adjacents")
                       |> Enum.min()

        p < min_adjacent
      end)
    end)
    |> IO.inspect
    |> Enum.map(fn {value, _} -> String.to_integer(value) + 1 end)
    |> Enum.sum()
  end

  def add_adj_to_list(new_adjacent, adjacents), do: [new_adjacent] ++ adjacents

  #### Four corners
  def get_adjacent(0, 0, _, _, grid), do: # top left 
    get_right(grid, 0, 0) |> get_down(grid, 0, 0)

  def get_adjacent(0, col_nr, _, nr_of_columns, grid) when col_nr + 1 == nr_of_columns, do: # top right
    get_left(grid, 0, col_nr) |> get_down(grid, 0, col_nr)
  
  def get_adjacent(row_nr, 0, nr_of_rows, _, grid) when row_nr + 1 == nr_of_rows, do: # bottom left
    get_right(grid, row_nr, 0) |> get_up(grid, row_nr, 0)

  def get_adjacent(row_nr, col_nr, nr_of_rows, nr_of_columns, grid) when row_nr + 1 == nr_of_rows and col_nr + 1 == nr_of_columns, do: # bottom right
  get_left(grid, row_nr, col_nr) |> get_up(grid, row_nr, col_nr)

  
  #### Four rows

  def get_adjacent(0, col_nr, _, _, grid), do: # top row
    get_right(grid, 0, col_nr) |> get_left(grid, 0, col_nr) |> get_down(grid, 0, col_nr)

  def get_adjacent(row_nr, col_nr, nr_of_rows, _, grid) when row_nr + 1 == nr_of_rows, do: # bottom row
  get_up(grid, row_nr, col_nr) |> get_right(grid, row_nr, col_nr) |> get_left(grid, row_nr, col_nr)

  def get_adjacent(row_nr, 0, _, _, grid), do: # left side
  get_down(grid, row_nr, 0) |> get_right(grid, row_nr, 0) |> get_up(grid, row_nr, 0)

  def get_adjacent(row_nr, col_nr, _, nr_of_columns, grid) when col_nr + 1 == nr_of_columns, do: # right side
  get_up(grid, row_nr, col_nr) |> get_down(grid, row_nr, col_nr) |> get_left(grid, row_nr, col_nr)

  #### The rest
  def get_adjacent(row_nr, col_nr, _, _, grid), do: 
    get_right(grid, row_nr, col_nr) |> get_left(grid, row_nr, col_nr) |> get_up(grid, row_nr, col_nr) |> get_down(grid, row_nr, col_nr) 

    def get_left(adjacents \\ [], grid, row_nr, col_nr), do: 
      Enum.at(grid, row_nr)
      |> Enum.at(col_nr - 1)
      |> add_adj_to_list(adjacents) 
    
    def get_right(adjacents \\ [], grid, row_nr, col_nr), do: 
      Enum.at(grid, row_nr)
      |> Enum.at(col_nr + 1)
      |> add_adj_to_list(adjacents) 

    def get_up(adjacents \\ [], grid, row_nr, col_nr), do: 
      Enum.at(grid, row_nr - 1)
      |> Enum.at(col_nr)
      |> add_adj_to_list(adjacents) 

    def get_down(adjacents \\ [], grid, row_nr, col_nr), do: 
      Enum.at(grid, row_nr + 1)
      |> Enum.at(col_nr)
      |> add_adj_to_list(adjacents) 


  def part2(args) do
  end
end
