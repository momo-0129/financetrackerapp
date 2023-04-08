class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      company = Alphavantage::Fundamental.new(symbol: ticker_symbol)
      if company.overview.empty?
        throw new Exception("Compant overview is empty")
      end
    
      return new(
        ticker: ticker_symbol, 
        name: company.overview.name, 
        last_price: company.overview.book_value
      )
    rescue Exception => e
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
