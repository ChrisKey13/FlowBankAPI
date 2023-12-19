require_relative 'transaction_combiner'

class TransactionMatcher
    def initialize(accounts, transactions)
      @accounts = accounts
      @transactions = transactions
    end
  
    def match_transactions
      account_transaction_pairs = {}
  
      @accounts.each do |account|
        combiner_service = TransactionCombiner.new(account, @transactions)
        valid_combinations = combiner_service.find_combinations
  
        sorted_combinations = valid_combinations.sort_by { |combo| -combo.length }
        best_combination = sorted_combinations.first

        puts "Account ID: #{account.id}, Best Combination: #{best_combination.map(&:id)}"

  
        account_transaction_pairs[account.id] = best_combination unless best_combination.nil?
      end
  
      account_transaction_pairs
    end
  end
  