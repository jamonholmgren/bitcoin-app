describe 'BitCoinScreen' do
  it "sets the current bitcoin price in USD" do
    screen = BitCoinScreen.new
    screen.set_state({
      bitcoin_prices: {
        "USD" => { "global_averages" => { "last" => 2.52 } },
      },
      last_fetched_date: "2015-03-21",
      currency: "USD",
      currencies: [ "USD" ],
    })

    screen.find(:bitcoin_price).data.should == "2.52 USD"
    screen.find(:last_fetched_date).data.should == "2015-03-21"
    screen.find(:cycle_currency).data.should == "USD"
  end
end
