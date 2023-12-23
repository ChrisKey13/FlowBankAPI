# config/routes.rb
Rails.application.routes.draw do
  post '/process_data', to: 'banking#process_data'
  post '/transaction_history', to: 'banking#transaction_history'

end
