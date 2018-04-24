Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post 'groupmebot/:bot_id', to: 'group_me_bot#index'
  end
end
