module LibraryName
  include GroupmeBotHelper

  LIBRARY_NAME_COMMANDS = [:library_name, :command1, :command2, :commandX]

  def library_name(parameters = nil)
    case parameters[0]
    when 'commands'
      message = "Commands: \n/" + LIBRARY_NAME_COMMANDS[1..(LIBRARY_NAME_COMMANDS.count-1)].join("\n/")
      send_message(@bot.bot_id, message)
    end
  end

  def command1()
  end

  def command2()
  end

  def commandX()
  end
end
