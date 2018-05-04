module ExpressionTracker
  include GroupmeBotHelper
  include RegexCreationHelper

  EXPRESSION_TRACKER_COMMANDS = [:expression_tracker, :new_expression, :delete_expression, :expressions]

  def expression_tracker(parameters = nil)
    case parameters[0]
    when 'commands'
      message = 'Commands: /' + LIBRARYNAME_COMMANDS[1..(LIBRARYNAME_COMMANDS.count-1)].join('\n/')
      send_message(@bot.bot_id, message)
    end
  end

  def expressions_tracker_parse(parameters)

  end

  def track_expression(parameters = nil)
    
  end

  def untrack_expression(parameters = nil)

  end

  def expressions(parameters = nil)

  end

  private
  def regex_creator
    @regex_creator ||= RegexCreationHelper::RegexCreator.new


end
# expression: "something" graph: true/false respond: true/false
