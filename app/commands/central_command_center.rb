module CentralCommandCenter
  include GroupmeBotHelper
  include Runescape

  # Rules:
  # 1) All functions must be downcase
  # 2) Function names must be unique across all command libraries
  # 3) All libraries must be put into LIBRARIES array
  # 4) All library must have a COMMANDS array

  LIBRARIES = { 'runescape'=> RUNESCAPE_COMMANDS }

  def run_command(input, group_member, user, group, bot)
    @group = group
    @bot = bot
    @user = user
    @group_member = group_member
    send_message(@bot_id, "Permission Denied") && return if @group_member.access_level == "none"
    command = input[0]
    parameters = input[1..(input.count-1)] unless input.count < 2
    self.send(input[0], parameters)
  end

  def add_library(parameters = [])
    return send_message(@bot.bot_id, "Usage: /add_library library_name1 library_name2 ...") if parameters.count < 1
    parameters.each do |library|
      case library
      when LIBRARIES[0]
      end
    end
  end

  def refresh_libraries

  end
end
