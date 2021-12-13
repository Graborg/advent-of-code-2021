defmodule AdventOfCode.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Day12

  @tag :skip
  test "part1" do
    input =
      """
      dc-end
      HN-start
      start-kj
      dc-start
      dc-HN
      LN-dc
      HN-end
      kj-sa
      kj-HN
      kj-dc
      """
      |> String.split("\n", trim: true)

    result = part1(input)

    assert result == 19
  end

  @tag :skip
  test "part1withInput" do
    input =
      AdventOfCode.Input.get!(12, 2021)
      |> String.split("\n", trim: true)

    result = part1(input)
    IO.inspect(result, label: "\n Answer d12p01")
    assert result == 4573
  end

  @tag :skip
  test "part2" do
    input =
      """
      dc-end
      HN-start
      start-kj
      dc-start
      dc-HN
      LN-dc
      HN-end
      kj-sa
      kj-HN
      kj-dc
      """
      |> String.split("\n", trim: true)

    result = part2(input)

    assert result == 103
  end

  @tag :skip
  test "part2withInput" do
    input =
      AdventOfCode.Input.get!(12, 2021)
      |> String.split("\n", trim: true)

    result = part2(input)
    IO.inspect(result, label: "\n Answer d12p02")
    assert result == 117_509
  end
end
