class AppDelegate < PM::Delegate
  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    open BitCoinScreen
  end
end
