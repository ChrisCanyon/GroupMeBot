module LibraryName
  include GroupmeBotHelper

  LIBRARYNAME_COMMANDS = [:library_name, :command1, :command2, :commandX]

  def library_name(parameters = nil)
    case parameters[0]
    when 'commands'
      message = 'Commands: /' + LIBRARYNAME_COMMANDS][1..(LIBRARYNAME_COMMANDS.count-1)].join('\n/')
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
