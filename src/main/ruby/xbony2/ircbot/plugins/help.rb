class Help
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match "help"
  def execute(msg)
    msg.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten @@quote, and @@archive."
    msg.reply "Owner only commands: @@stop, @@upload, @@lyrics, @@addcat, @@addcata, and @@trans."
  end
end
