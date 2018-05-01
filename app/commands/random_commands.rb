
  def roll
    begin
      x = params[:text].downcase.split(' ')[1].to_i
      send_message(@bot_id, "#{rand(x)}")
    rescue
      send_message(@bot_id, "usage: /roll number")
    end
  end

  def high_score
    string_builder = "High Score:\n"
    users = User.all.map { |user| [user.name,user.messages.count] }
    users.sort!{ |x,y| y[1] <=> x[1] }
    users.each_with_index do |user, index|
      string_builder += "#{index + 1})#{user[0]}: #{user[1]}\n"
    end
    string_builder
  end

  def process_request
    @user.requests.create(requested_feature: params[:text])
    "Request saved!"
  end

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

  def tag
    sample = User.all.sample
    attachments = [{ "loci": [[0, sample.name.length + 1]], "type": "mentions", "user_ids": ["#{sample.groupme_id}"] }]
    send_message(@bot_id, "@#{sample.name}", attachments)
  end
