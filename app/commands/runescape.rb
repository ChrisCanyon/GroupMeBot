module Runescape
  include GroupmeBotHelper

  RUNESCAPE_COMMANDS = [:runescape, :test, :update]

  def as(parameters = nil)
    send_message(@bot.bot_id, "it works")
  end

  def test(parameters = nil)
    p 'ello'
  end

  def update

  end
end
