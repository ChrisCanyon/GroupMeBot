module Api
  class GroupMeBotController < Api::BaseController
    include CentralCommandCenter

    def index
      setup
      process_message unless params['sender_type'] == 'bot' || (params['sender_type'] == 'system')
    end

    private
      def setup
        @group = get_group
        @bot = get_bot
        @user = get_user
        @group_member = get_group_member
      end

      def get_group
        Group.find_or_create_by(external_id: params[:group_id])
      end

      def get_bot
        return @group.bot if @group.bot.present?
        Bot.create(group: @group, bot_id: params[:bot_id])
      end

      def get_user
        User.find_or_create_by(external_id: params[:user_id])
      end

      def get_group_member
        member = @group.group_members.find_or_create_by(group: @group, user: @user, external_id: 1)
        return member unless member.name != params[:name]
        member.name = params[:name]
        member.old_names << member.name
        member.save
        member
      end


      PARSING_LIBRARIES = []
      def process_message
        text = params[:text].downcase
        (@bot.active_libraries & PARSING_LIBRARIES).each do |library|
          parse_text(library, text)
        end

        command_type = text.slice!(0)
        parsed_params = text.split(' ')

        if ('/' == command_type)
          if @bot.active_commands.include?(parsed_params[0])
            run_command(parsed_params, command_type)
          else
            send_message(@bot.bot_id, "Unknown Command: #{parsed_params[0]}. Try #{command_type}commands for a list of commands")
          end
        elsif ('!' == command_type)
          run_command(parsed_params, command_type)
        end
      end
  end
end
