module UserCommandCenterHelper
  include GroupmeBotHelper

  COMMANDS = ["/usage", "/highscore", "/request", "/price", "/stake", "/roll"]

  # todo: change this name
  def run_normal_command(command, bot_id, user)
    @user = user
    @bot_id = bot_id

    case command
    when COMMANDS[0]
      send_message(@bot_id, usage)
    when COMMANDS[1]
      send_message(@bot_id, high_score)
    when COMMANDS[2]
      send_message(@bot_id, process_request)
    when COMMANDS[3]
      price_check
    when COMMANDS[4]
      stake
    when COMMANDS[5]
      roll
    else
      send_message(@bot_id, unknown_command)
    end
  end

  private
  def stake
    options = ['win', 'lose']
    send_message(@bot_id, "You #{options.sample}")
  end

  def roll
    begin
      x = params[:text].downcase.split(' ')[1].to_i
      send_message(@bot_id, "#{rand(x)}")
    rescue
      send_message(@bot_id, "usage: /roll number")
    end
  end

  def price_check
    item_name = params[:text].downcase.split(' ')
    item_name.delete_at(0)
    item = search_items(item_name.join(' ').downcase)

    send_message(@bot_id, "Unknown item: #{item_name.join(' ')}") && return if item.blank?
    send_message(@bot_id, "Search Results:\n#{ item[0..9].map { |x| x.item_name }.join("\n") }\n#{item.count - 10} more options...") && return if item.count > 10
    send_message(@bot_id, "Search Results:\n#{ item.map { |x| x.item_name }.join("\n") }") && return if item.count > 1

    results = find_item(item.first.item_id)

    current_price = results['item']['current']['price']
    day_30_trend = results['item']['day30']['change']
    day_90_trend = results['item']['day90']['change']
    day_180_trend = results['item']['day180']['change']
    send_message(@bot_id, "Current Price: #{current_price}\n30 day trend: #{day_30_trend}\n90 day trend: #{day_90_trend}\n180 day trend: #{day_180_trend}")
  end

  def find_item(item_id)
    uri = URI("http://services.runescape.com/m=itemdb_oldschool/api/catalogue/detail.json?item=#{item_id}")
    JSON.parse(Net::HTTP.get(uri))
  end

  def search_items(item_name)
    OsrsItem.all.select { |x| x.item_name.include? item_name }
  end

  def process_request
    @user.requests.create(requested_feature: params[:text])
    "Request saved!"
  end

  def usage
    string_builder = "COMMANDS: "
    COMMANDS.each do |value|
      string_builder += "#{value} "
    end
    string_builder
  end

  def unknown_command
    "Invalid Command. Type /usage for a list of commands"
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
end
