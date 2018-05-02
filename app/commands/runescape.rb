module Runescape
  include GroupmeBotHelper

  RUNESCAPE_COMMANDS = [:runescape, :price, :stake]

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

    return send_message if items.count != 0
    results = find_item(item['id'])

    current_price = results['item']['current']['price']
    day_30_trend = results['item']['day30']['change']
    day_90_trend = results['item']['day90']['change']
    day_180_trend = results['item']['day180']['change']
    send_message(@bot.bot_id, "Current Price: #{current_price}\n30 day trend: #{day_30_trend}\n90 day trend: #{day_90_trend}\n180 day trend: #{day_180_trend}")
  end

  private
    def inconclusive_search(items)
      send_message(@bot.bot_id, "Unknown item: #{item_name.join(' ')}") && return if item.blank?
      send_message(@bot.bot_id, "Search Results:\n#{ item[0..9].map { |x| x['name'] }.join("\n") }\n#{item.count - 10} more options...") && return if item.count > 10
      send_message(@bot.bot_id, "Search Results:\n#{ item.map { |x| x['name'] }.join("\n") }") && return if item.count > 1
    end

    def find_item(item_id)
      uri = URI("http://services.runescape.com/m=itemdb_oldschool/api/catalogue/detail.json?item=#{item_id}")
      JSON.parse(Net::HTTP.get(uri))
    end

    def search_items(item_name)
      items = JSON.parse(File.read('osrs_items.json'))
      searched = items.select { |item| item['name'].downcase.include? item_name }
      return searched.select { |item| item['name'].downcase == item_name}
      searched
    end
end
