module CentralCommandCenter
  include GroupmeBotHelper
  include BasicCommands

  def run_command(input, group_member, user, group, bot)
    @group = group
    @bot = bot
    @user = user
    @group_member = group_member
    p 'here I am'
    send_message(@bot_id, "Permission Denied") && return if @group_member.access_level == "none"
    command = input[0]
    parameters = input[1..(input.count-1)] unless input.count < 2
    self.send(input[0], parameters)
    p 'I done did it'
  end
end
