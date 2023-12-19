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
          puts "Combination: #{subset.map(&:id)} with Total Amount: #{total_amount}, Account Balance: #{@account.balance}"
          if total_amount <= @account.balance
            valid_combinations << subset
            puts "Valid Combination Added: #{subset.map(&:id)}"
          end
        end
      end
  
  
      valid_combinations
    end
  end
  