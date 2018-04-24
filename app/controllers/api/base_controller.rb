module Api
  class BaseController < ::ApplicationController
    protect_from_forgery with: :null_session
    include GroupmeBotHelper
    include CentralCommandCenterHelper
  end
end
