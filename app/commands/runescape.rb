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
    item = search_items(item_name.join(' ').downcase)

    send_message(@bot.bot_id, "Unknown item: #{item_name.join(' ')}") && return if item.blank?
    send_message(@bot.bot_id, "Search Results:\n#{ item[0..9].map { |x| x.item_name }.join("\n") }\n#{item.count - 10} more options...") && return if item.count > 10
    send_message(@bot.bot_id, "Search Results:\n#{ item.map { |x| x.item_name }.join("\n") }") && return if item.count > 1

    results = find_item(item.first.item_id)

    current_price = results['item']['current']['price']
    day_30_trend = results['item']['day30']['change']
    day_90_trend = results['item']['day90']['change']
    day_180_trend = results['item']['day180']['change']
    send_message(@bot.bot_id, "Current Price: #{current_price}\n30 day trend: #{day_30_trend}\n90 day trend: #{day_90_trend}\n180 day trend: #{day_180_trend}")
  end

  private
    def find_item(item_id)
      uri = URI("http://services.runescape.com/m=itemdb_oldschool/api/catalogue/detail.json?item=#{item_id}")
      JSON.parse(Net::HTTP.get(uri))
    end

    def search_items(item_name)
      items = JSON.parse(File.read('../../osrs_items.json'))
      items.select { |item| item['name'].downcase.include? item_name }
    end
end
