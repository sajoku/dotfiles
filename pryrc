# frozen_string_literal: true

Pry.editor = "vi"

# == Pry-Nav - Using pry as a debugger ==
begin
  Pry.commands.alias_command "c", "continue"
rescue StandardError
  nil
end
begin
  Pry.commands.alias_command "s", "step"
rescue StandardError
  nil
end
begin
  Pry.commands.alias_command "n", "next"
rescue StandardError
  nil
end

# == PLUGINS ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
begin
  require "awesome_print"
rescue LoadError
  puts "gem install awesome_print"
end
