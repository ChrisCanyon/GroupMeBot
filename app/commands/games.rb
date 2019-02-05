module Games
  include GroupmeBotHelper

  GAMES_COMMANDS = [:games, :start_tic_tac_toe, :play_tic_tac_toe]

  def games(parameters = nil)
    case parameters[0]
    when 'commands'
      message = "Commands: \n/" + GAMES_COMMANDS[1..(GAMES_COMMANDS.count-1)].join("\n/")
      send_message(@bot.bot_id, message)
    end
  end

  def start_tic_tac_toe(parameters = nil)
    board = "*|*|*\n*|*|*\n*|*|*\n"
    message = "+play_tic_tac_toe X\n" + board
    send_message(@bot.bot_id, message)
  end

  def play_tic_tac_toe(parameters = nil)
    if (parameters.count == 0 || ['X', 'O'].include?(parameters[0]))
      return send_message(@bot.bot_id, "Invalid request. Required 'X' or 'O' not found")
    end

    board = parse_tic_tac_toe_board(parameters[1..(parameters.count-1)])
    return send_message(@bot.bot_id, "You win") if check_victory(board)

    message = "+play_tic_tac_toe "
    if (parameters[0] == 'X')
      message += "O\n"
    else
      message += "X\n"
    end

    board = make_move(board)

    message += build_board_from_array(board)
    send_message(@bot.bot_id, message)
  end

  private
  def make_move(board)
    # this is where logic goes to make a move
    return board
  end

  def check_victory(board)
    p "checking victory\n"
    # check rows
    board.each do |x|
      if (x[0] == x[1] && x[1] == x[2] && x[0] != '*')
        return true
      end
    end
    # check columns
    3.times do |i|
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != '*')
        return true
      end
    end
    # check diagonals
    if(board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != '*')
      return true
    end
    if(board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != '*')
      return true
    end
    return false
  end

  def parse_tic_tac_toe_board(board)
    parsed = []
    board.each do |x|
      parsed.push(x.upcase.split('|'))
    end
    return parsed
  end

  def build_board_from_array(array)
    output = ""
    array.each do |x|
      output += x.join('|') + "\n"
    end
    return output
  end

end
