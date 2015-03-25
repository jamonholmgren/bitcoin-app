class BitCoinScreen < PM::Screen
  title "Bitcoin Price"
  stylesheet BitCoinScreenStylesheet

  def on_load
    @state = {
      bitcoin_prices: {},
      last_fetched_date: nil,
      currency: "USD",
      currencies: [ "USD", "AUD", "CAD", "EUR" ],
    }
    set_state(@state)
    load_prices
  end

  def set_state(state)
    # Build the UI initially if it hasn't been built yet
    build_initial_ui if find(:bitcoin_price).length == 0

    bitcoin_price = bitcoin_price_for_currency(state)

    # Set all the UI elements to reflect the current state
    find(:bitcoin_price).data("#{bitcoin_price} #{state[:currency]}")
    find(:last_fetched_date).data(state[:last_fetched_date])
    find(:cycle_currency).data(state[:currency])
  end

  def build_initial_ui
    append(UILabel, :bitcoin_price)
    append(UILabel, :last_fetched_date)
    append(UIButton, :cycle_currency).on(:tap) do
      rotate_currency
    end
  end

  def rotate_currency
    @state[:currency] = @state[:currencies].rotate(@state[:currencies].index(@state[:currency]) + 1).first
    set_state(@state)
  end

  def bitcoin_price_for_currency(state)
    return "Loading" unless state[:bitcoin_prices][state[:currency]]
    state[:bitcoin_prices][state[:currency]]["global_averages"]["last"]
  end

  def load_prices
    AFMotion::JSON.get("https://api.bitcoinaverage.com/all") do |result|
      if result.success?
        @state[:bitcoin_prices] = result.object
        @state[:last_fetched_date] = Time.now.strftime("%b %e, %l:%M %p")
        set_state(@state)
      else
        mp result
      end
    end
  end
end
