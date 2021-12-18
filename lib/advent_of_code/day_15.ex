defmodule AdventOfCode.Day15 do
  def part1(args) do
    IO.inspect(args)
    max_indices = {Enum.count(args) - 1, Enum.count(args) - 1}
    # bottom right corner / the exit
    start_stack = [{max_indices, 0}]

    base_case = base_case(args, max_indices)

    loop(start_stack, %{}, args, base_case)
    |> Map.get({0, 0})
  end

  def base_case(grid, stop), do: base_case_lopp({0, 1}, grid, stop)
  def base_case_lopp(stop, grid, stop), do: get_risk(stop, grid)

  def base_case_lopp({y, y} = coord, grid, stop),
    do: get_risk(coord, grid) + base_case_lopp({y, y + 1}, grid, stop)

  def base_case_lopp({x, y} = coord, grid, stop),
    do: get_risk(coord, grid) + base_case_lopp({x + 1, y}, grid, stop)

  def loop([], map, _grid, _base_case), do: map

  def loop([{{0, 0} = coord, risk} | rest], map, grid, base_case) do
    IO.puts("FINISHED")

    new_map =
      if risk < Map.get(map, coord, 1_000_000) && risk < base_case,
        do: Map.put(map, coord, risk),
        else: map

    loop(rest, new_map, grid, base_case)
  end

  def loop([{coord, old_risk} | rest] = stack, map, grid, base_case) do
    new_risk = get_risk(coord, grid) + old_risk
    IO.inspect(stack)

    # Map.keys(map)
    # |> Enum.count()
    # |> IO.inspect(label: "size of map")

    if new_risk < Map.get(map, coord, base_case) && new_risk < base_case do
      new_map = Map.put(map, coord, new_risk)

      #   h = Map.get(map, coord, base_case)
      #   if !is_nil(h), do: IO.inspect("replacing")

      #   Map.keys(map)
      #   |> Enum.count()
      #   |> IO.inspect(label: "size of map 2")

      new_elems =
        get_new_coords(coord, new_risk, grid, map, base_case)
        |> Enum.map(fn coord -> {coord, new_risk} end)

      new_list =
        new_elems
        |> Enum.reduce(Enum.reverse(rest), fn x, curr_stack -> [x | curr_stack] end)
        |> Enum.reverse()

      loop(new_list, new_map, grid, base_case)
    else
      #   IO.puts("THRWO IT!")
      loop(rest, map, grid, base_case)
    end
  end

  def get_new_coords({x, y}, old_risk, grid, map, base_case),
    do:
      [{x + 1, y}, {x, y + 1}, {x - 1, y}, {x, y - 1}]
      |> Enum.reject(fn coords -> get_risk(coords, grid) |> is_nil() end)
      |> Enum.reject(fn coords ->
        new_risk = old_risk + get_risk(coords, grid)
        new_risk > Map.get(map, coords, base_case) || new_risk > base_case
      end)

  def get_risk({x, y}, _grid) when x < 0 or y < 0, do: nil

  def get_risk({x, y}, grid) do
    row = Enum.at(grid, y)
    if is_nil(row), do: nil, else: Enum.at(row, x)
  end

  def part2(args) do
  end
end
