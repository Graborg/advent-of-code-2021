defmodule AdventOfCode.Day04 do
  def part1([drawings, boards]) do
     IO.inspect(drawings, label: "draw")
     IO.inspect(boards, label: "before")
    Enum.reduce_while(drawings, boards, fn draw_nr, boards_state -> 
      new_boards_state = Enum.map(boards_state, fn board_state -> Enum.map(board_state, fn row -> Enum.map(row, fn x -> if x != draw_nr, do: x end) end) end)
      
      winner = get_winners(new_boards_state)
      if !is_nil(winner) do 
        calc_sum(Enum.at(new_boards_state, winner))
        {:halt, calc_sum(Enum.at(new_boards_state, winner)) * String.to_integer(draw_nr)}  
      else 
        {:cont, new_boards_state}
      end
    end)

  end

  def get_winners(boards) do
    boards
      |> Enum.with_index()
      |> Enum.reduce([], fn ({board, index}, acc) -> 
        column_winner = Enum.zip_with(board, fn column ->
          Enum.all?(column, fn x -> is_nil(x) end) 
        end)
          |> Enum.any?()

        row_winner = Enum.any?(board, fn row -> 
          Enum.all?(row, fn x -> is_nil(x) end)
        end)
        if column_winner || row_winner, do: [index | acc], else: acc
      end) 
  end

  def calc_sum(board) do
    Enum.flat_map(board, fn row -> 
      Enum.reject(row, fn x -> is_nil(x) end) 
      |> Enum.map(&String.to_integer/1) end)
    |> Enum.sum()
  end


  def part2([drawings, boards]) do
     IO.inspect(drawings, label: "draw")
     IO.inspect(boards, label: "before")
    Enum.reduce_while(drawings, boards, fn draw_nr, boards_state -> 
      new_boards_state = Enum.map(boards_state, fn board_state -> 
        Enum.map(board_state, fn row -> 
          Enum.map(row, fn x -> if x != draw_nr, do: x end) 
        end) 
      end)
      winners = get_winners(new_boards_state)
                |> IO.inspect(label: "winners")
      if !Enum.empty?(winners) do
        boards_without_winner = new_boards_state 
          |> Enum.with_index()
          |> Enum.filter(fn {_e, index} -> !Enum.member?(winners, index) end)
          |>Enum.map(fn x -> elem(x, 0) end)
        IO.inspect(new_boards_state, label: "state")
        if Enum.count(new_boards_state) == 1 do 
          IO.inspect("halting")
          {:halt, calc_sum(Enum.at(new_boards_state, 0)) * String.to_integer(draw_nr)}  
        else 
          {:cont, boards_without_winner}
        end
      else 
        {:cont, new_boards_state}
      end
    end)
  end
end
