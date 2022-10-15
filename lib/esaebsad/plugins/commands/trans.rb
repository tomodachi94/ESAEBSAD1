class Trans < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /trans (.*); (.+)/
  def execute(msg, page, special)
    if is_op? msg.user.authname, "ftb"
      text = get_client.get_text(page) # gets text from the wiki
      text = text.gsub(/\[\[Category:.+\]\]/){|s| s.gsub /\]\]/, "{{L}}]]"} # appends {{L}} to category links
      text = text.gsub(/<br\/>/, "<br />")
      text = text.gsub(/<languages\/>/, "<languages />")
      text = text.gsub(/\[\[.+\]\]/){|s| !s.start_with?("[[Category:", "[[File:", "[[wikipedia:", "[[WP:") ? s.gsub(/\[\[/, "{{L|").gsub(/\]\]/, "}}") : s} # replaces [[links]] with {{L|links}}, excluding links starting with Category, File, WP and wikipedia
      text = text.gsub(/\{\{[Ii]nfobox\n/, "{{Infobox{{L}}\n") # L'ifies infoboxes
      text = text.gsub(/\{\{[Ii]nfobox mod\n/, "{{Infobox mod{{L}}\n") # L'ifies infoboxes
      # localizes fields in infoboxes
      %w(name lore module effects storageslots storage exp modpacks requires dependency neededfor neededforpast requirespast dependecypast description).each do |s|
        text = text.gsub(/\|#{s}=.+\n/){|ns| ns.insert(2 + s.length, "<translate>").insert(-2, "</translate>")}
      end

      text = text.gsub(/\|mod=.+\n/){|s| !s.end_with?("}}\n") ? s.insert(5, "<translate>").insert(-2, "</translate>") : s} # inserts translate tags
      text = text.gsub(/\{\{Cg\/.+\n/){|s| s.insert(-2, "{{L}}")} # L'ifies Cg
      text = text.gsub(/\{\{Navbox .+\}\}/){|s| s.insert(-3, "{{L}}")} # L'ifies Navboxes
      # adds translators' note regarding translation restoration project
      text = text.insert(0, "<translate><!--Translators note: this article is part of the [[project:Translation Restoration project|Translation Restoration project]]--></translate>\n") if special == "in"
      get_client.edit(page, text, summary = "Added translation markup.") # saves all of this
      msg.reply(localize("command.shared.link", "http://ftb.gamepedia.com/#{urlize(page)}"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
