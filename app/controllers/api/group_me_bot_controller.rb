module Api
  class GroupMeBotController < Api::BaseController
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

      def process_message
        send_message(@bot.bot_id, @group.to_json)
        send_message(@bot.bot_id, @bot.to_json)
        send_message(@bot.bot_id, @user.to_json)
        send_message(@bot.bot_id, @group_member.to_json)
      end
  end
end
