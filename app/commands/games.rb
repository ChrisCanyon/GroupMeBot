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
    message = "+play_tic_tac_toe "
    if (parameters[0] == 'X')
      message += "O\n"
    else
      message += "X\n"
    end

    board = parse_tic_tac_toe_board(parameters[1..(parameters.count-1)])

  end

  private

  def parse_tic_tac_toe_board(board)
      p board
  end

  def build_board_from_array(array)

  end

end
