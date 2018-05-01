module Runescape
  include GroupmeBotHelper

  RUNESCAPE_COMMANDS = [:runescape]

  def runescape(parameters = nil)
    return send_message(@bot.bot_id, "Try '/runescape commands' for more options") unless parameters
    case parameters[0]
    when 'commands'
      message = 'Commands: /' + RUNESCAPE_COMMANDS[1..(RUNESCAPE_COMMANDS.count-1)].join('\n/')
      send_message(@bot.bot_id, message)
    end
  end
end
