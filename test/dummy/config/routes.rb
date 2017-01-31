Rails.application.routes.draw do
  scope ENV['RAILS_RELATIVE_URL_ROOT'] || '/' do
    resources :callback, only: [:create] 
  end
end
