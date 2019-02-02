module AdminCommands
  include GroupmeBotHelper

  ADMIN_COMMANDS = ["test", "revoke", "grant", "commands", "ruby"]
  ADMIN_ID = '13682993'

  def run_admin_command(command)
    @bot_id = @bot.bot_id
    send_message(@bot_id, "Access Denied") && return unless @group_member.access_level == 'admin'
    return send_message(@bot_id, "Try '!commands' for more options") unless command.length > 0

    case command[0]
    when ADMIN_COMMANDS[0]
      test_function()
    when ADMIN_COMMANDS[1]
      revoke()
    when ADMIN_COMMANDS[2]
      grant()
    when ADMIN_COMMANDS[3]
      admin_commands()
    when ADMIN_COMMANDS[4]
      ruby(command[1..(command.count-1)])
    else
      send_message(@bot_id, "Invalid Command")
    end
  end

  private
  def admin_commands
    message = "Commands: \n/" +  ADMIN_COMMANDS[1..(ADMIN_COMMANDS.count-1)].join("\n/")
    send_message(@bot_id, message)
  end

  def grant
    send_message(@bot_id, "Usage: Tag someone to grant") && return unless valid_permission_change_params?
    groupme_ids = params[:attachments][0][:user_ids]
    groupme_ids.each do |id|
      user_to_grant = User.where(external_id: id).first
      group_member_to_grant = user_to_grant.group_members.where(:group_id == @group.id)
      group_member_to_grant.update(access_level: "admin") unless user_to_grant.external_id == ADMIN_ID
    end
    send_message(@bot_id, "Permission(s) granted")
  end

  def revoke
    send_message(@bot_id, "Usage: Tag someone to revoke") && return unless valid_permission_change_params?
    groupme_ids = params[:attachments][0][:user_ids]
    groupme_ids.each do |id|
      user_to_revoke = User.where(external_id: id).first
      group_member_to_revoke = user_to_revoke.group_members.where(:group_id == @group.id)
      group_member_to_revoke.update(access_level: "none") unless user_to_revoke.external_id == ADMIN_ID
    end
    send_message(@bot_id, "Permission(s) revoked")
  end

  def valid_permission_change_params?
    params[:attachments].present? && params[:attachments][0][:type] == "mentions"
  end

  def ruby(parameters)
    #join parameters
    script = parameters.join(' ')
    #write file filename
    f = File.new("temp.rb", "w+")
    f.write(script)
    f.close
    p script
    message = `ruby temp.rb`
    p "Script output: " + message
    send_message(@bot_id, message)
  end

  def test_function
    sample = @group.group_members.sample
    attachments = [{ "loci": [[0, sample.name.length + 1]], "type": "mentions", "user_ids": ["#{sample.user.external_id}"] }]
    send_message(@bot_id, "@#{sample.name}", attachments)
  end
end
