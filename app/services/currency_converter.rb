require 'net/http'
require 'json'

module CurrencyConverter
    API_URL = 'https://api.exchangerate-api.com/v4/latest/EUR'
    @rates_cache = {}
    @last_updated = Time.now
  
    def self.convert_to_eur(price, currency)
      rate = fetch_live_rate(currency)
      price / rate
    end
  
    def self.fetch_live_rate(currency)
      update_rates if @rates_cache.empty? || Time.now - @last_updated > 3600
      @rates_cache.fetch(currency, 1)
    end
  
    def self.update_rates
      uri = URI(API_URL)
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      @rates_cache = data['rates']
      @last_updated = Time.now
    rescue StandardError => e
      # Handle exceptions or log errors as needed
    end
end
  