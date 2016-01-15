class Archive < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "archive", <<EOS
Group: all. Syntax: "@@archive (url)"
The archive shorten command will backup a url using the Internet Archieve (archive.com).
EOS
  set :prefix, /^@@/
  match /archive (.+)/
  def execute(msg, url)
    open "http://web.archive.org/save/#{url}"
    msg.reply "Will be available here shortly: https://web.archive.org/web/*/#{url}"
  end
end
