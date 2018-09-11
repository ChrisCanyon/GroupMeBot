module Runescape
  include GroupmeBotHelper

  RUNESCAPE_COMMANDS = [:runescape, :price, :stake, :high_score]

  def runescape(parameters = nil)
    return send_message(@bot.bot_id, "Try '/runescape commands' for more options") unless parameters
    case parameters[0]
    when 'commands'
      message = 'Commands: /' + RUNESCAPE_COMMANDS[1..(RUNESCAPE_COMMANDS.count-1)].join('\n/')
      send_message(@bot.bot_id, message)
    end
  end

  def stake(parameters = nil)
    options = ['win', 'lose']
    send_message(@bot.bot_id, "You #{options.sample}")
  end

  def price(parameters = nil)
    item_name = params[:text].downcase.split(' ')
    item_name.delete_at(0)
    items = search_items(item_name.join(' ').downcase)

    return inconclusive_search(items) if items.count != 1

    results = find_item(items.first['id'])

    current_price = results['item']['current']['price']
    day_30_trend = results['item']['day30']['change']
    day_90_trend = results['item']['day90']['change']
    day_180_trend = results['item']['day180']['change']
    send_message(@bot.bot_id, "Current Price: #{current_price}\n30 day trend: #{day_30_trend}\n90 day trend: #{day_90_trend}\n180 day trend: #{day_180_trend}")
  end

  def high_score(parameters = nil)
    send_message(@bot.bot_id, "Usage: /high_score player_name") unless parameters
    players = {}
    parameters.each { |player_name| players[player_name] = parse_player(player_name) }
    message = "#{players.keys.join(' | ')}\n"
    STATS.each do |stat|
      message += "#{players.map{ |name, stats| stats[stat].to_s }.join(' | ')} :#{stat.to_s}\n"
    end
    send_message(@bot.bot_id, message)
  end

  private
    def inconclusive_search(items)
      send_message(@bot.bot_id, "Unknown item") && return if items.blank?
      send_message(@bot.bot_id, "Search Results:\n#{ items[0..9].map { |x| x['name'] }.join("\n") }\n#{items.count - 10} more options...") && return if items.count > 10
      send_message(@bot.bot_id, "Search Results:\n#{ items.map { |x| x['name'] }.join("\n") }") && return if items.count > 1
    end

    def find_item(item_id)
      uri = URI("http://services.runescape.com/m=itemdb_oldschool/api/catalogue/detail.json?item=#{item_id}")
      JSON.parse(Net::HTTP.get(uri))
    end


    STATS = [:total_level, :attack, :defence, :strength, :hitpoints, :ranged, :prayer, :magic,
    :cooking, :woodcutting, :fletching, :fishing, :firemkaing, :crafting, :smithing,
    :mining, :herblore, :agility, :theiving, :slayer, :farming, :runecrafting, :hunter]
    def parse_player(player_name)
      raw_player_stats = find_player(player_name)
      p "raw player stats:"
      p raw_player_stats
      return send_message(@bot.bot_id, "Unknown player: #{player_name}") unless raw_player_stats
      player_stats = {}
      STATS.each_with_index do |stat, index|
        player_stats[stat] = raw_player_stats[index].split(',')[1]
      end
      player_stats
    end

    def find_player(player_name)
      uri = URI("https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?player=#{player_name}")
      response = Net::HTTP.get_response(uri)
      p "response", response
      return nil unless response.code == '200'
      response.body.split("\n")
    end

    def search_items(item_name)
      items = JSON.parse(File.read('osrs_items.json'))
      searched = items.select { |item| item['name'].downcase.include? item_name }
      specific_item = searched.select { |item| item['name'].downcase == item_name}
      return specific_item unless specific_item.blank?
      searched
    end
end
