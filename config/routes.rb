Rails.application.routes.draw do
  root 'data_gatherer#index'
  resources :data_gatherer
  namespace :api, defaults: { format: :json } do
    post 'gnome_child', to: 'gnome_child#index'
    post 'pax_bot', to: 'pax_bot#index'
    post 'test', to: 'test#index'
  end
end
