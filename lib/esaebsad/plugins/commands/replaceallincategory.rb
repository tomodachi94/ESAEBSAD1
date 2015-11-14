class ReplaceAllInCategory < ESAEBSADCommand
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /replaceallincategory (.*); (.*); (.+|.?)/
  def execute(msg, cat, oldtext, newtext)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      get_client.get_category_members("Category:#{cat}").each do |page|
        puts page
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(/#{oldtext}/, newtext), summary: "Converting \"#{oldtext}\" to \"#{newtext}\"") if text.include?(oldtext)
      end
      msg.reply "Process complete."
    end
  end
end
