require 'httparty'

class CryptoData
  include HTTParty
  base_uri 'https://api.coingecko.com/api/v3'

  def fetch_crypto_data
    response = self.class.get("/coins/markets?vs_currency=usd")
    JSON.parse(response.body)
  end

  def top_5_cryptos_by_market_cap
    crypto_data = fetch_crypto_data
    sorted_cryptos = crypto_data.sort_by { |crypto| -crypto['market_cap'] }

    top_5_cryptos = sorted_cryptos.take(5)
    top_5_cryptos.map do |crypto|
      {
        name: crypto['name'],
        price: crypto['current_price'],
        market_cap: crypto['market_cap']
      }
    end
  end
end

crypto_data = CryptoData.new
top_5_cryptos = crypto_data.top_5_cryptos_by_market_cap

puts "Top 5 Cryptocurrencies by Market Capitalization:"
top_5_cryptos.each_with_index do |crypto, index|
    puts "#{index + 1}. #{crypto[:name]}"
    puts "   Price: $#{crypto[:price]}"
    puts "   Market Cap: $#{crypto[:market_cap]}"
end