require_relative '../../lib/protos/protos/fyber_userconfiguration_pb'

class Protobuf
  def self.generate_protobuf_data(account_transaction_pairs)
    account_seq = FYBER::Userconfiguration::AccountSeq.new

    account_transaction_pairs.each do |account_id, transactions|
      account_with_transactions = FYBER::Userconfiguration::AccountSeq::AccountWithTransactions.new

      # Since account_id is a string, directly use it to create the account protobuf
      account_with_transactions.account = FYBER::Userconfiguration::Account.new(id: account_id)

      transactions.each do |transaction|
        transaction_proto = FYBER::Userconfiguration::Transaction.new(
          id: transaction.id, 
          amount: transaction.amount, 
          currency: transaction.currency
        )
        account_with_transactions.transactions << transaction_proto
      end

      account_seq.account << account_with_transactions
    end

    account_seq.to_proto
  end

  def self.generate_protobuf_history_data(filtered_transactions)
    transaction_history = FYBER::Userconfiguration::TransactionHistory.new

    filtered_transactions.each do |transaction|
      transaction_proto = FYBER::Userconfiguration::Transaction.new(
        id: transaction.id,
        account_id: transaction.account_id,
        amount: transaction.amount,
        currency: transaction.currency,
        type: transaction.type,
        date: transaction.date
      )
      transaction_history.transactions << transaction_proto
    end

    transaction_history.to_proto
  end
end
