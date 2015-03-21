class BitCoinScreen < PM::Screen
  title "Bitcoin Price"
  stylesheet BitCoinScreenStylesheet

  def on_load
    @bitcoin_prices = {}
    @bitcoin_price = nil
    @last_fetched = nil
    @currency = "USD"
    @currencies = [ "USD", "AUD", "CAD", "EUR" ]

    append(UILabel, :bitcoin_price).data("Loading...")
    append(UILabel, :last_fetched_date).data("...")
    append(UIButton, :cycle_currency).data(@currency).on(:tap) do
      # Get next currency
      @currency = @currencies.rotate(@currencies.index(@currency) + 1).first
      @bitcoin_price = @bitcoin_prices[@currency]["global_averages"]["last"]
      find(:bitcoin_price).data("#{@bitcoin_price} #{@currency}")
      find(:cycle_currency).data(@currency)
    end

    load_prices
  end

  def load_prices
    AFMotion::JSON.get("https://api.bitcoinaverage.com/all") do |result|
      if result.success?
        @bitcoin_prices = result.object
        @bitcoin_price = @bitcoin_prices[@currency]["global_averages"]["last"]
        find(:bitcoin_price).data("#{@bitcoin_price} #{@currency}")
        find(:last_fetched_date).data(Time.now.strftime("%b %e, %l:%M %p"))
      else
        mp result
      end
    end
  end

end
