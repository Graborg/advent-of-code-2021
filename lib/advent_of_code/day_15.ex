defmodule AdventOfCode.Day15 do
  def part1(args) do
    max_indices = {Enum.count(args) - 1, Enum.count(args) - 1}
    # start from bottom right corner / the exit
    start_stack = %{max_indices => get_risk(max_indices, args)}

    base_case = base_case(args, max_indices)

    loop(start_stack, %{}, args, base_case)
    |> print_map(args, max_indices)
    |> Map.get({0, 0})
  end

  def base_case(grid, stop), do: base_case_loop({0, 1}, grid, stop)
  def base_case_loop(stop, grid, stop), do: get_risk(stop, grid)

  def base_case_loop({y, y} = coord, grid, stop),
    do: get_risk(coord, grid) + base_case_loop({y, y + 1}, grid, stop)

  def base_case_loop({x, y} = coord, grid, stop),
    do: get_risk(coord, grid) + base_case_loop({x + 1, y}, grid, stop)

  def loop(stack, map, _grid, _base_case) when stack == %{}, do: map

  def loop(stack, map, grid, base_case) when is_map_key(stack, {0, 0}) do
    start_coord = {0, 0}
    {total_risk, new_stack} = Map.pop!(stack, start_coord)

    new_map =
      if total_risk < Map.get(map, start_coord, base_case) && total_risk < base_case,
        do: Map.put(map, start_coord, total_risk),
        else: map

    loop(new_stack, new_map, grid, Enum.min([total_risk, base_case]))
  end

  def loop(stack, map, grid, base_case) do
    {coord, risk} = List.first(Map.to_list(stack))
    popped_stack = Map.delete(stack, coord)
    risk_from_map = Map.get(map, coord, base_case)

    if risk < risk_from_map && risk < base_case do
      new_map = Map.put(map, coord, risk)

      new_elems =
        get_new_coords(coord, grid)
        |> Enum.map(fn new_coord ->
          {new_coord, risk + get_risk(new_coord, grid)}
        end)
        |> Enum.reject(fn {new_coord, new_risk} ->
          risk_on_coord_in_stack = Map.get(popped_stack, new_coord, base_case)
          risk_in_map = Map.get(new_map, new_coord, base_case)

          higher_than_in_map = new_risk > risk_in_map
          higher_than_in_stack = new_risk > risk_on_coord_in_stack

          higher_than_in_stack || higher_than_in_map ||
            risk > base_case
        end)

      new_stack =
        new_elems
        |> Enum.reduce(popped_stack, fn {c, c_risk}, tmp_stack ->
          Map.put(tmp_stack, c, c_risk)
        end)

      loop(new_stack, new_map, grid, base_case)
    else
      loop(popped_stack, map, grid, base_case)
    end
  end

  def print_map(map, grid, stop) do
    IO.puts("")
    pathway = get_path(map, {0, 0}, grid, stop)

    size = map |> Map.to_list() |> Enum.count()
    length = :math.sqrt(size) |> round() |> Kernel.-(1)

    for y <- 0..length do
      for x <- 0..length do
        risk = Map.get(map, {x, y}, 0) |> Integer.to_string()
        risk = if String.length(risk) == 1, do: "0" <> risk, else: risk

        if {x, y} in pathway,
          do: IO.ANSI.light_blue_background() <> risk <> IO.ANSI.reset() <> " ",
          else: risk <> " "
      end
    end
    |> Enum.join("\n")
    |> IO.write()

    IO.puts("")
    map
  end

  def get_path(_map, stop, _grid, stop), do: [stop]

  def get_path(map, coord, grid, stop) do
    next =
      get_new_coords(coord, grid)
      |> Enum.map(fn c -> {c, Map.get(map, c)} end)
      |> Enum.sort(fn {_, risk}, {_, risk2} -> risk < risk2 end)
      |> Enum.map(fn {c, _} -> c end)
      |> List.first()

    [coord | get_path(map, next, grid, stop)]
  end

  def get_new_coords({x, y}, grid),
    do:
      [{x + 1, y}, {x, y + 1}, {x - 1, y}, {x, y - 1}]
      |> Enum.reject(fn coords -> get_risk(coords, grid) |> is_nil() end)

  def get_risk({x, y}, _grid) when x < 0 or y < 0, do: nil

  def get_risk({0, 0}, _grid), do: 0

  def get_risk({x, y}, grid) do
    row = Enum.at(grid, y)
    if is_nil(row), do: nil, else: Enum.at(row, x)
  end

  def part2(args) do
  end
end
