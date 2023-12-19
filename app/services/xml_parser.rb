require 'nokogiri'
require_relative '../../lib/protos/protos/fyber_userconfiguration_pb'


class XmlParser
  def initialize(xml_content)
    @xml_doc = Nokogiri::XML(xml_content)
  end

  def parse_data
    {
      accounts: parse_accounts,
      transactions: parse_transactions
    }
  end

  private

  def parse_accounts
    accounts = []
    @xml_doc.xpath('//Accounts/Account').each do |account_node|
      id = account_node['id']
      balance = account_node['balance'].to_f
      currency = account_node['currency']
      converted_balance = CurrencyConverter.convert_to_eur(balance, currency)
      accounts << FYBER::Userconfiguration::Account.new(id: id, balance: converted_balance, currency: 'EUR')
    end
    accounts
  end

  def parse_transactions
    transactions = []
    @xml_doc.xpath('//Transactions/Transaction').each do |transaction_node|
      id = transaction_node['id']
      amount = transaction_node['amount'].to_f
      currency = transaction_node['currency']
      converted_amount = CurrencyConverter.convert_to_eur(amount, currency)
      transactions << FYBER::Userconfiguration::Transaction.new(id: id, amount: converted_amount, currency: 'EUR')
    end
    transactions
  end
end
