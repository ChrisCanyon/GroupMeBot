module Api
  class PaxBotController < Api::BaseController
    require 'open-uri'
    require 'net/https'

    BOT_ID = '6d9ee567d5dccdb1d416606199'

    def index
      process_message unless params['sender_type'] == 'bot' || (params['sender_type'] == 'system')
    end

  private
    def process_message
      check_command(params[:text][0])
    end

    def check_command(escape_key)
      keys = ['/', '!']
      send_message(BOT_ID, 'Meow') if params[:text].downcase[/(\bpax\b|\bpaxton\b)/]
      send_message(BOT_ID, 'Purr') if params[:text].downcase[/(\bhali\b)/]      
    end
  end
end
