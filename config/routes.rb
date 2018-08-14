Rails.application.routes.draw do
  resources :alerts
  get '/' => 'log_metrics#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
