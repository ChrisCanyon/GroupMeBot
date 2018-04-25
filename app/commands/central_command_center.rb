module CentralCommandCenter
  include GroupmeBotHelper
  include AdminCommandCenter
  include UserCommandCenter

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
end
