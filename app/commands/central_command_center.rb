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

  def libraries(parameters = nil)
    send_message(@bot.bot_id, "Libraries:\n#{LIBRARIES.keys.join("\n")}")
  end

  def commands(parameters = nil)
    send_message(@bot.bot_id, "Commands:\n#{@bot.active_commands.join("\n")}")
  end

  def add_library(parameters = [], print=true)
    return send_message(@bot.bot_id, "Usage: /add_library library_name1 library_name2 ...") unless parameters
    parameters.each do |library|
      next if @bot.active_libraries.include?(library)
      commands = LIBRARIES[library]
      unless commands.blank?
        @bot.active_commands = @bot.active_commands + commands
        @bot.active_libraries << library
      end
    end
    @bot.save
    send_message(@bot.bot_id, 'Libraries added') if print
  end

  def active_libraries(parameters = nil)
    return send_message(@bot.bot_id, "No active libraries") unless @bot.active_libraries.count > 0
    send_message(@bot.bot_id, "Active Libraries:\n#{@bot.active_libraries.join("\n")}")
  end

  def remove_library(parameters = nil)
    parameters.each do |library|
      @bot.active_libraries.delete(library)
    end
    @bot.save
    refresh_libraries
    send_message(@bot.bot_id, 'Libraries removed')
  end

  def refresh_libraries(parameters = nil)
    @bot.active_commands = Bot.new.active_commands
    add_library(@bot.active_libraries, false)
  end

  def request_feature(parameters = nil)
    return unless parameters
    @user.requests.create(requested_feature: parameters.join(' '))
    send_message(@bot.bot_id, "Request added")
  end
end
