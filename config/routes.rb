Rails.application.routes.draw do
  get '/node_ids' => 'prediction#node_id'
  get '/app_options' => 'prediction#app_options'
  get '/prediction/log_metric_prediction'
  post '/chartdata' => 'prediction#chart_data'
  resources :alerts
  get '/' => 'log_metrics#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
