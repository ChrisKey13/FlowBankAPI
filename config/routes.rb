# config/routes.rb
Rails.application.routes.draw do
  post '/process_data', to: 'banking#process_data'


end
