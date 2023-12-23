require 'nokogiri'
require_relative '../../lib/protos/protos/fyber_userconfiguration_pb'

class XmlParser
  include Singleton

  attr_accessor :xml_content
  attr_reader :accounts, :transactions

  def self.set_xml_data(xml_content)
    if instance.xml_content != xml_content
      instance.xml_content = xml_content
      instance.parse_data
      pp "New data source file"
    else
      pp "the xml file remains unchanged"
    end
  end

  def self.get_cached_data
    instance.cached_data
  end

  def cached_data
    {
      accounts: @accounts,
      transactions: @transactions
    }
  end

  def parse_data
    return if @xml_content.nil?

    xml_doc = Nokogiri::XML(xml_content)
    @accounts = parse_nodes(xml_doc, '//Accounts/Account', method(:extract_account_data))
    @transactions = parse_nodes(xml_doc, '//Transactions/Transaction', method(:extract_transaction_data))
  end

  private

  def initialize
    @accounts = []
    @transactions = []
  end


  def parse_nodes(xml_doc, xpath, data_extractor)
    xml_doc.xpath(xpath).map do |node|
      data = data_extractor.call(node)
      create_protobuf_object(data)
    end
  end

  def extract_account_data(node)
    {
      id: node['id'],
      balance: CurrencyConverter.convert_to_eur(node['balance'].to_f, node['currency']),
      currency: 'EUR'
    }
  end

  def extract_transaction_data(node)
    {
      id: node['id'],
      account_id: node['account_id'],
      amount: CurrencyConverter.convert_to_eur(node['amount'].to_f, node['currency']),
      currency: 'EUR',
      type: node['type'],
      date: node['date']
    }
  end

  def create_protobuf_object(data)
    if data.key?(:account_id)
      FYBER::Userconfiguration::Transaction.new(data)
    else
      FYBER::Userconfiguration::Account.new(data)
    end
  end
end