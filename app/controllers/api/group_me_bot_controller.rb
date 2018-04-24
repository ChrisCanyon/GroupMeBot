module Api
  class GroupMeBotController < Api::BaseController
    BOT_ID = '16d752b470ff5d9e8f1e2ffc49'
    GROUP_ID = '40328258'
    def index
      process_message unless params['sender_type'] == 'bot' || (params['sender_type'] == 'system')
    end

    def process_message
      send_message(BOT_ID, params.to_s)
    end
  end
end
  
