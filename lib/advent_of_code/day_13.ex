defmodule AdventOfCode.Day13 do
  def get_folds(args) do
    Enum.filter(args, fn x -> String.starts_with?(x, "fold") end)
    |> Enum.map(fn "fold along " <> fold ->
      [axis, index] = String.split(fold, "=")
      {axis, String.to_integer(index)}
    end)
  end

  def part1(args) do
    folds = get_folds(args)

    dot_indices =
      args
      |> Enum.reject(fn x -> String.starts_with?(x, "fold") end)
      |> Enum.map(fn x -> String.split(x, ",", trim: true) |> Enum.map(&String.to_integer/1) end)
      |> get_dot_indices_after_folds(folds)

    max_x =
      dot_indices
      |> Enum.map(fn [x, _] -> x end)
      |> Enum.max()

    max_y =
      dot_indices
      |> Enum.map(fn [_, y] -> y end)
      |> Enum.max()

    map = List.duplicate(List.duplicate(".", max_x + 1), max_y + 1)

    dot_indices
    |> Enum.reduce(map, fn [x, y], acc ->
      List.update_at(acc, y, fn row ->
        List.update_at(row, x, fn _ -> "#" end)
      end)
    end)
    |> print_grid()
  end

  def get_dot_indices_after_folds(dots, folds),
    do:
      Enum.reduce(folds, dots, fn fold, acc_dots ->
        Enum.map(acc_dots, fn [x, y] -> j(x, y, fold) end)
      end)

  def j(x, y, {"y", index}) when y > index, do: [x, index - (y - index)]

  def j(x, y, {"x", index}) when x > index, do: [index - (x - index), y]
  def j(x, y, {_, _}), do: [x, y]

  def print_grid(grid) do
    IO.write("\n")

    Enum.map(grid, fn row -> Enum.map(row, &add_color_to_letter/1) end)
    |> Enum.join("\n")
    |> IO.write()

    IO.write("\n")
  end

  def add_color_to_letter("#"), do: IO.ANSI.green_background() <> " " <> IO.ANSI.reset()
  def add_color_to_letter("."), do: IO.ANSI.red_background() <> " " <> IO.ANSI.reset()

  def part2(_) do
    ""
  end
end
