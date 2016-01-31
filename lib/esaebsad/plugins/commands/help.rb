class Help < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "help"
  set :prefix, /^@@/
  match "help", method: :list
  match /help (.+)/, method: :advanced

  def list(msg)
    msg.reply "List of commands: #{ESAEBSAD::Utility::HELP_COMMANDS.keys.join(", ")}"
  end

  def advanced(msg, command)
    help = ESAEBSAD::Utility::HELP_COMMANDS
    message = help.include?(command) ? help[command] : "Command not found."
    msg.reply(message)
  end
end
