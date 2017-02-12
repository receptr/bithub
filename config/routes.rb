Rails.application.routes.draw do
  namespace :github do
    resource :webhook, only: :create
  end
end
