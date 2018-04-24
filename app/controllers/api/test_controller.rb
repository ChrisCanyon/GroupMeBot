class TestController < Api::BaseController
  BOT_ID = '16d752b470ff5d9e8f1e2ffc49'
  GROUP_ID = '40328258'
  def index
    send_message(BOT_ID, 'Hello')
  end
end
