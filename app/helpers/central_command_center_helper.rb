module CentralCommandCenterHelper
  include GroupmeBotHelper
  include AdminCommandCenterHelper
  include UserCommandCenterHelper

  def run_command(command, bot_id, user)
    @user = user
    @bot_id = bot_id
    command = params[:text].downcase.split(' ')[0]
    send_message(@bot_id, "Permission Denied") && return if @user.access_level == "none"
    case command[0]
    when '/'
      run_normal_command(command, bot_id, user)
    when '!'
      run_admin_command(command, bot_id, user)
    end
  end
end
