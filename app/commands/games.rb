module Games
  include GroupmeBotHelper

  GAMES_COMMANDS = [:library_name, :command1, :command2, :commandX]

  def games(parameters = nil)
    case parameters[0]
    when 'commands'
      message = "Commands: \n/" + GAMES_COMMANDS[1..(GAMES_COMMANDS.count-1)].join("\n/")
      send_message(@bot.bot_id, message)
    end
  end

  def command1(parameters = nil)

  end

  def command2(parameters = nil)

  end

  def commandX(parameters = nil)

  end
end
