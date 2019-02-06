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
    message = "/play_tic_tac_toe X\n" + board
    send_message(@bot.bot_id, message)
  end

  def play_tic_tac_toe(parameters = nil)
    sleep(1)
    if (parameters.count == 0 || ['X', 'O'].include?(parameters[0]))
      return send_message(@bot.bot_id, "Invalid request. Required 'X' or 'O' not found")
    end

    board = parse_tic_tac_toe_board(parameters[1..(parameters.count-1)])
    (win, type) = check_victory(board)
    return send_message(@bot.bot_id, "#{type} wins") if win

    message = "/play_tic_tac_toe "
    move_type = parameters[0].upcase
    if (move_type == 'X')
      message += "O\n"
    else
      message += "X\n"
    end

    board = make_move(board, move_type)

    message += build_board_from_array(board)
    send_message(@bot.bot_id, message)
  end

  private
  def make_move(board, move_type)
    # check if i have a winning move
    3.times do |i|
      3.times do |j|
        tmp = board
        tmp[i,j] = move_type if tmp[i,j] == '*'
        (a,b) = check_victory(board)
        if a
          board[i,j] = move_type
          return board
        end
      end
    end

    # check if they have a winning move
    3.times do |i|
      3.times do |j|
        tmp = board
        tmp[i,j] = other_move(move_type) if tmp[i,j] == '*'
        (a,b) = check_victory(board)
        if a
          board[i,j] = move_type
          return board
        end
      end
    end

    if board_empty?(board)
      board[0][0] = move_type
      return board
    end

    # if there isnt a forced move do my own move
    best_board = nil
    best_score = 0
    3.times do |i|
      3.times do |j|
        tmp = board
        tmp[i,j] = move_type if tmp[i,j] == '*'
        s = score_board(tmp, move_type)
        if s > best_score
          best_board = tmp
          best_score = s
        end
      end
    end

    return best_board
  end

  def board_empty?(board)
    3.times do |i|
      3.times do |j|
        return false if board[i][j] != '*'
      end
    end
    return true
  end

  def score_board(board, move_type)
    # create sets of scoring positions
    sets = []

    # check rows
    board.each do |x|
      t = 0
      x.each do |y|
        if (y == move_type)
          t += 1
        end
      end
      sets.push(t)
    end

    #check columns
    3.times do |i|
      t = 0
      t += 1 if (board[0][i] == move_type)
      t += 1 if (board[1][i] == move_type)
      t += 1 if (board[2][i] == move_type)
      sets.push(t)
    end

    #check diagonals
    t = 0
    t += 1 if (board[0][0] == move_type)
    t += 1 if (board[1][1] == move_type)
    t += 1 if (board[2][2] == move_type)
    sets.push(t)

    t = 0
    t += 1 if (board[0][2] == move_type)
    t += 1 if (board[1][1] == move_type)
    t += 1 if (board[2][0] == move_type)
    sets.push(t)

    #compute final score
    finalScore = 0
    sets.each do |x|
      finalScore += (x * 10) ** 2
    end
    return finalScore
  end

  def other_move(move_type)
    if(move_type == 'X')
      return 'O'
    else
      return 'X'
    end
  end

  def check_victory(board)
    # check rows
    board.each do |x|
      if (x[0] == x[1] && x[1] == x[2] && x[0] != '*')
        return true, x[0]
      end
    end
    # check columns
    3.times do |i|
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != '*')
        return true, board[0][i]
      end
    end
    # check diagonals
    if(board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != '*')
      return true, board[0][0]
    end
    if(board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != '*')
      return true, board[0][2]
    end
    return false, nil
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
