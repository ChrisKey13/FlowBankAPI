# app/controllers/banking_controller.rb
class BankingController < ApplicationController
    def process_data
      xml_data = request.body.read
  
      parser = XmlParser.new(xml_data)
      parsed_data = parser.parse_data

      matcher = TransactionMatcher.new(parsed_data[:accounts], parsed_data[:transactions])

      matched_data = matcher.match_transactions
  

      protobuf_output = Protobuf.generate_protobuf_data(matched_data)
  
      send_data protobuf_output, type: 'application/octet-stream', disposition: 'attachment'
    end
  
  end
  