defmodule AdventOfCode.Day15 do
  def part1(args) do
    IO.inspect(args)
    max_indices = {Enum.count(args) - 1, Enum.count(args) - 1}
    # bottom right corner / the exit
    start_stack = %{max_indices => 0}

    base_case =
      base_case(args, max_indices)
      |> IO.inspect(label: "base_case")

    loop(start_stack, %{}, args, base_case)
    |> Map.get({0, 0})
  end

  def base_case(grid, stop), do: base_case_lopp({0, 1}, grid, stop)
  def base_case_lopp(stop, grid, stop), do: get_risk(stop, grid)

  def base_case_lopp({y, y} = coord, grid, stop),
    do: get_risk(coord, grid) + base_case_lopp({y, y + 1}, grid, stop)

  def base_case_lopp({x, y} = coord, grid, stop),
    do: get_risk(coord, grid) + base_case_lopp({x + 1, y}, grid, stop)

  def loop(stack, map, _grid, _base_case) when stack == %{}, do: map

  def loop(stack, map, grid, base_case) when is_map_key(stack, {0, 0}) do
    IO.puts("FINISHED")
    {risk, new_stack} = Map.pop!(stack, {0, 0})
    IO.inspect(risk)

    new_map =
      if risk < Map.get(map, {0, 0}, base_case) && risk < base_case,
        do: Map.put(map, {0, 0}, risk),
        else: map

    loop(new_stack, new_map, grid, Enum.min([risk, base_case]))
  end

  def loop(stack, map, grid, base_case) do
    {coord, old_risk} = List.first(Map.to_list(stack))
    popped_stack = Map.delete(stack, coord)
    new_risk = get_risk(coord, grid) + old_risk

    if new_risk < Map.get(map, coord, base_case) && new_risk < base_case do
      new_map = Map.put(map, coord, new_risk)

      new_elems =
        get_new_coords(coord, grid)
        |> Enum.reject(fn new_coord ->
          new_new_risk = new_risk + get_risk(new_coord, grid)
          risk_on_coord_in_stack = Map.get(popped_stack, new_coord, base_case)
          risk_in_map = Map.get(new_map, new_coord, base_case)

          new_new_risk > risk_on_coord_in_stack || new_new_risk > risk_in_map ||
            new_new_risk > base_case
        end)

      new_stack =
        new_elems
        |> Enum.reduce(popped_stack, fn c, tmp_stack ->
          Map.put(tmp_stack, c, new_risk)
        end)

      loop(new_stack, new_map, grid, base_case)
    else
      loop(popped_stack, map, grid, base_case)
    end
  end

  def print_map(map) do
    size = map |> Map.to_list() |> Enum.count() |> IO.inspect()
    length = :math.sqrt(size) |> round() |> Kernel.-(1)

    Enum.each(0..length, fn y ->
      Enum.map(0..length, fn x ->
        Map.get(map, {x, y}, "#")
      end)
      |> IO.inspect(limit: :infinity, width: :infinity)
    end)

    map
  end

  def get_new_coords({x, y}, grid),
    do:
      [{x + 1, y}, {x, y + 1}, {x - 1, y}, {x, y - 1}]
      |> Enum.reject(fn coords -> get_risk(coords, grid) |> is_nil() end)

  def get_risk({x, y}, _grid) when x < 0 or y < 0, do: nil

  def get_risk({x, y}, grid) do
    row = Enum.at(grid, y)
    if is_nil(row), do: nil, else: Enum.at(row, x)
  end

  def part2(args) do
  end
end
