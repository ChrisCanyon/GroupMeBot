module AdminCommands
  include GroupmeBotHelper

  ADMIN_COMMANDS = ["!test", "!revoke", "!grant"]
  ADMIN_ID = '13682993'

  def run_admin_command(command, bot_id, user)
    @user = user
    @bot_id = bot_id

    send_message(@bot_id, "Permission Denied") && return unless @user.access_level == 'admin'

    case command
    when ADMIN_COMMANDS[0]
      test_function
    when ADMIN_COMMANDS[1]
      revoke
    when ADMIN_COMMANDS[2]
      grant
    else
      send_message(@bot_id, "Invalid Command")
    end
  end

  private
  def grant
    send_message(@bot_id, "Usage: Tag someone to grant") && return unless valid_permission_change_params?
    groupme_ids = params[:attachments][0][:user_ids]
    groupme_ids.each do |id|
      user_to_grant = User.where(groupme_id: id).first
      user_to_grant.update(access_level: "standard") unless user_to_grant.groupme_id == ADMIN_ID
    end
    send_message(@bot_id, "Permission(s) granted")
  end

  def revoke
    send_message(@bot_id, "Usage: Tag someone to revoke") && return unless valid_permission_change_params?
    groupme_ids = params[:attachments][0][:user_ids]
    p groupme_ids
    groupme_ids.each do |id|
      user_to_revoke = User.where(groupme_id: id).first
      user_to_revoke.update(access_level: "none") unless user_to_revoke.groupme_id == ADMIN_ID
    end
    send_message(@bot_id, "Permission(s) revoked")
  end

  def valid_permission_change_params?
    params[:attachments].present? && params[:attachments][0][:type] == "mentions"
  end

  def test_function
    sample = User.all.sample
    attachments = [{ "loci": [[0, sample.name.length + 1]], "type": "mentions", "user_ids": ["#{sample.groupme_id}"] }]
    send_message(@bot_id, "@#{sample.name}", attachments)
  end
end
