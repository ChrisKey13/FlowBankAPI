require 'time'
require_relative 'transaction_combiner'

class TransactionMatcher
    def initialize(accounts, transactions)
      @accounts = accounts
      @transactions = transactions || []
    end
  
    def match_transactions
      account_transaction_pairs = {}
  
      @accounts.each do |account|
        time = Time.now
        next if @transactions.nil?
        
        combiner_service = TransactionCombiner.new(account, @transactions)
        valid_combinations = combiner_service.find_combinations
        
        sorted_combinations = valid_combinations.sort_by { |combo| -combo.length }
        best_combination = sorted_combinations.first
        
        puts * 2
        puts "============================================================"
        puts
        puts "Processing #{account.id}"
        if best_combination
          puts "Account ID: #{account.id}, Best Combination: #{best_combination.map(&:id)}"
          account_transaction_pairs[account.id] = best_combination
        else
          puts "Account ID: #{account.id}, No valid combinations found"
        end

        puts "time elapsed '#{Time.now - time}'"
        puts
        puts "============================================================"
        puts * 2
      end
  
      account_transaction_pairs
    end
  end