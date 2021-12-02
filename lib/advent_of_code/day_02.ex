defmodule AdventOfCode.Day02 do
  def part1(args) do
    Enum.reduce(args, {0,0}, &handle_command/2)
  end

  def handle_command("forward " <> x, {hpos, dpos}), do: {hpos + String.to_integer(x), dpos}
  
  def handle_command("down " <> x, {hpos, dpos}), do: {hpos, dpos + String.to_integer(x)}

  def handle_command("up " <> x, {hpos, dpos}), do: {hpos, dpos - String.to_integer(x)}

  def part2(args) do


  end
end
