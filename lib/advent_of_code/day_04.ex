defmodule AdventOfCode.Day04 do
  def part1([drawings, boards]) do
     IO.inspect(drawings, label: "draw")
     IO.inspect(boards, label: "before")
    Enum.reduce_while(drawings, boards, fn draw_nr, boards_state -> 
      new_boards_state = Enum.map(boards_state, fn board_state -> Enum.map(board_state, fn row -> Enum.map(row, fn x -> if x != draw_nr, do: x end) end) end)
      
      winner = get_winner(new_boards_state)
      if !is_nil(winner) do 
        calc_sum(Enum.at(new_boards_state, winner))
        {:halt, calc_sum(Enum.at(new_boards_state, winner)) * String.to_integer(draw_nr)}  
      else 
        {:cont, new_boards_state}
      end
    end)

  end

  def get_winner(boards) do
    boards
      |> Enum.with_index()
      |> Enum.reduce_while(nil, fn ({board, index}, _acc) -> 
        column_winner = Enum.zip_with(board, fn column ->
          Enum.all?(column, fn x -> is_nil(x) end) 
        end)
          |> Enum.any?()

        row_winner = Enum.any?(board, fn row -> 
          Enum.all?(row, fn x -> is_nil(x) end)
        end)
        if column_winner || row_winner, do: {:halt, index}, else: {:cont, nil}
      end) 
  end

  def calc_sum(board) do
    Enum.flat_map(board, fn row -> 
      Enum.reject(row, fn x -> is_nil(x) end) 
      |> Enum.map(&String.to_integer/1) end)
    |> Enum.sum()
  end


  def part2(args) do
  end
end
