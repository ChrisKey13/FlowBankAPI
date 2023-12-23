class TransactionCombiner
    def initialize(account, transactions)
      @account = account
      @transactions = transactions
    end
  
    def find_combinations
      valid_combinations = []
  
      (1..@transactions.size).each do |n|
        @transactions.combination(n).each do |subset|
          total_amount = subset.map(&:amount).sum
          if total_amount <= @account.balance
            valid_combinations << subset
          end
        end
      end
  
  
      valid_combinations
    end
  end
  