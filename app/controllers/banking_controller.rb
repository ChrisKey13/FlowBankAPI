# app/controllers/banking_controller.rb
class BankingController < ApplicationController
    before_action :set_and_cache_xml_data

    def process_data
      parsed_data = XmlParser.get_cached_data

      matcher = TransactionMatcher.new(parsed_data[:accounts], parsed_data[:transactions])
      matched_data = matcher.match_transactions
  

      protobuf_output = Protobuf.generate_protobuf_data(matched_data)
      send_data protobuf_output, type: 'application/octet-stream', disposition: 'attachment'
    end
  
    def transaction_history
      account_id = params[:account_id]
      time_frame = params[:time_frame] || 'All'

      parsed_data = XmlParser.get_cached_data
      account_transactions = parsed_data[:transactions].select { |t| t.account_id == account_id }
    
      filtered_transactions = TransactionFilter.filter(account_transactions, time_frame)
    
      protobuf_output = Protobuf.generate_protobuf_history_data(filtered_transactions)
      
      send_data protobuf_output, type: 'application/octet-stream', disposition: 'attachment'
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
    

    private

    def set_and_cache_xml_data
      xml_data = request.body.read
      XmlParser.set_xml_data(xml_data)
    end
end
  