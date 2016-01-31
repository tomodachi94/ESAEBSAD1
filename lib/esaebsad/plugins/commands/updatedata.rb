class UpdateData < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility
  
  create_help "updatedata"
  set :prefix, /^@@/
  match "updatedata", method: :update_full
  match /updatedata (.+)/, method: :update_specific
  
  def update_full(msg)
    update_data
    msg.reply "Process complete."
  end
  
  def update_specific(msg, emodule)
    update_data(emodule)
    msg.reply "Process complete."
  end
end
