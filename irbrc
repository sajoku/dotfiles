require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
require "awesome_print"
AwesomePrint.irb!
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
IRB.conf[:AUTO_INDENT]=true
