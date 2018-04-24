module GroupmeBotHelper
  # Does the talking to groupme
  BASE_URL = 'https://api.groupme.com'
  SEND_MESSAGE_PATH = '/v3/bots/post'
  HEADERS = { 'Content-Type' => 'application/json' }

  def get_message(group, message)
    JSON.parse(Net::HTTP.get(URI("https://api.groupme.com/v3/groups/#{group}/messages/#{message}?token=RNMl8G2s2QmFUAOGRphNKUo7JQkPrg452iIhyltF")))
  end

  def send_message(bot_id, message, attachments = {})
    p http.post(SEND_MESSAGE_PATH, { bot_id: bot_id, text: message, attachments: attachments }.to_json, HEADERS)
  end

  def http
    return @http if @http
    uri = URI.parse(BASE_URL)
    @http = Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = true
    end
  end
end
