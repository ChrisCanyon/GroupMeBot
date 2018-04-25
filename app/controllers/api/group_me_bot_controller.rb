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
        return @group.bot if group.bot.present?
        Bot.create(group: @group, external_id: params[:bot_id])
      end

      def get_user
        User.find_or_create_by(external_id: params[:user_id])
      end

      def get_group_member
        @group.group_members.find_or_create_by(group: group, user: user, external_id: 1)
      end

      def process_message
        send_message(@bot.external_id, @group.to_s)
        send_message(@bot.external_id, @bot.to_s)
        send_message(@bot.external_id, @user.to_s)
        send_message(@bot.external_id, @group_member.to_s)
      end
  end
end
