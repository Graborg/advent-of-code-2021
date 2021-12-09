defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  @tag :skip
  test "part1" do
    input = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
fgae cfgab fg bagce
"""
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, "|", trim: true) end)
|> Enum.map(fn p -> Enum.map(p, fn x -> String.split(x, " ", trim: true) end) end)
    result = part1(input)

    assert result == 26
  end

  @tag :skip
  test "part1withInput" do
    input = AdventOfCode.Input.get!(8, 2021)
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, "|", trim: true) end)
      |> Enum.map(fn p -> Enum.map(p, fn x -> String.split(x, " ", trim: true) end) end)
    result = part1(input)
    IO.inspect(result, label: "\n Answer d08p01")
  end

  @tag :skip
  test "part2" do
    input = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""
|> String.split("\n", trim: true)
|> Enum.map(fn x -> 
  [input, output] = x
      |> String.split("|", trim: true)  
      |> Enum.map(fn p -> String.split(p, " ", trim: true) end)
    %{input: input, output: output}
  end)
    result = part2(input)

    assert result == 61229
  end
  @tag :skip
  test "part2withInput" do
   input = AdventOfCode.Input.get!(8, 2021)
|> String.split("\n", trim: true)
|> Enum.map(fn x -> 
  [input, output] = String.split(x, "|", trim: true)  
                    |> Enum.map(fn p -> String.split(p, " ", trim: true) end)
    %{input: input, output: output}
end)
    result = part2(input)
    IO.inspect(result, label: "\n Answer d08p02")
  end
end
