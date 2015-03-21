class BitCoinScreenStylesheet < ApplicationStylesheet
  def root_view(st)
    st.background_color = color.white
  end

  def bitcoin_price(st)
    st.frame = {
      left:           20,
      from_right:     20,
      top:            100,
      height:         50,
    }
    st.text = "Loading..."
    st.text_alignment = :center
    st.font = UIFont.boldSystemFontOfSize(40.0)
  end

  def last_fetched_date(st)
    st.frame = {
      left:           20,
      from_right:     20,
      below_previous: 100,
      height:         50,
    }
    st.text = "Loading..."
    st.text_alignment = :center
    st.font = UIFont.systemFontOfSize(24.0)
  end

  def cycle_currency(st)
    st.frame = {
      left:           20,
      from_right:     20,
      below_previous: 100,
      height:         50,
    }
    st.font = UIFont.systemFontOfSize(24.0)
    st.color = UIColor.blackColor
  end
end
