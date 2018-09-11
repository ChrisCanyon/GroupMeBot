module Api
  class PaxBotController < Api::BaseController
    require 'open-uri'
    require 'net/https'

    BOT_ID = 'b6514c53899b3fe8c4cc8452a8'

    def index
      process_message unless params['sender_type'] == 'bot' || (params['sender_type'] == 'system')
    end

  private
    def process_message
      check_command(params[:text][0])
    end

    def check_command(escape_key)
      send_message(BOT_ID, 'Purr') if params[:text].downcase[/(\bhali\b)/]
    end
  end
end
