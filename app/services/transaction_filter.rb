# app/services/transaction_filter.rb
module TransactionFilter
    extend ActiveSupport::Concern
  
    TIME_FRAMES = {
      '1D' => 1.day.ago,
      '7D' => 7.days.ago,
      '1M' => 1.month.ago,
      '1Y' => 1.year.ago,
      'All' => Time.at(0)
    }.freeze
  
    def self.filter(transactions, time_frame)
      start_date = TIME_FRAMES[time_frame]
      transactions.select { |transaction| transaction.date >= start_date }
    end
  end
  