defmodule AdventOfCode.Day10 do
  def part1(args) do
    Enum.map(args, fn x -> String.split(x, "", trim: true) end)
    |> Enum.map(fn sequence -> how_bad(sequence, []) end)
    |> Enum.sum()
  end

  def part2(args) do
    scores =
      Enum.map(args, fn x -> String.split(x, "", trim: true) end)
      |> Enum.map(fn sequence -> how_bad(sequence, []) end)
      |> Enum.filter(&is_list/1)
      |> Enum.map(fn missing_endings -> Enum.reduce(missing_endings, 0, &rank_incomplete/2) end)
      |> Enum.sort()

    Enum.at(scores, round(Enum.count(scores) / 2) - 1)
  end

  def how_bad([], []), do: 0
  def how_bad([], opened) when length(opened) > 0, do: opened

  def how_bad([first_letter | rest_of_seq], []),
    do: how_bad(rest_of_seq, [get_closing(first_letter)])

  def how_bad([first_letter | rest_of_seq], [latest_opened | rest_opened])
      when first_letter == latest_opened,
      do: how_bad(rest_of_seq, rest_opened)

  def how_bad([first_letter | rest_of_seq], [latest_opened | rest_opened] = not_closed)
      when first_letter in ["(", "[", "{", "<"],
      do: how_bad(rest_of_seq, [get_closing(first_letter) | not_closed])

  def how_bad([first_letter | rest_of_seq], [latest_opened | rest_opened]), do: rank(first_letter)

  def get_closing("("), do: ")"
  def get_closing("["), do: "]"
  def get_closing("{"), do: "}"
  def get_closing("<"), do: ">"

  def rank(")"), do: 3
  def rank("]"), do: 57
  def rank("}"), do: 1197
  def rank(">"), do: 25137

  def rank_incomplete(")", acc), do: acc * 5 + 1
  def rank_incomplete("]", acc), do: acc * 5 + 2
  def rank_incomplete("}", acc), do: acc * 5 + 3
  def rank_incomplete(">", acc), do: acc * 5 + 4
end
