require "pry"
require "./lib/queue.rb"
require "./lib/messages.rb"

class Repl
  include Messages
  attr_reader :queue

  def initialize
    @queue = Queue.new
  end


  def get_user_input
    gets.chomp.downcase.split
  end

  def valid_help_query?(input)
    @help_commands.keys.any? { |key| key == input }
  end

  def valid_command?(input)
    @commands.keys.any? { |key| key == input }
  end


  def runner
    puts help_list
    input = get_user_input
    until input == "quit"
      case
      when input.first == "help"
       help_commands(input)
       input = get_user_input
      when input[0] == "load" && input.length == 1
        @queue.load
        puts "event_attendees.csv loaded"
        input = get_user_input
      when input[0] == "load" && input.length > 1
        @queue.load(input[1])
        puts "we've loaded your shitty csv, now what?"
        input = get_user_input
      when input[0] == "find"
        @queue.find(input[1], input[2..-1].join(" "))
        puts "the queue has been poulated by attendees with #{input[1].gsub("_", " ")}(s) #{input[2..-1].join(" ")} "
        input = get_user_input
      when input[0] == "queue"
        queue_commands(input)
        input = get_user_input
      when input[0] == "quit"
        puts "peace bitches"
        return
      else
        puts "try again"
        input = get_user_input
      end
    end
  end

  def help_commands(input)
    case
    when  input.join(" ") == "help"                   then puts help_list
    when  input.join(" ") == "help load"              then puts help_load
    when  input.join(" ") == "help find"              then puts help_find
    when  input.join(" ") == "help queue count"       then puts help_count
    when  input.join(" ") == "help queue clear"       then puts help_clear
    when  input.join(" ") == "help queue district"    then puts help_district
    when  input.join(" ") == "help queue print"       then puts help_print
    when  input.join(" ") == "help queue print by"    then puts help_print_by_attribute
    when  input.join(" ") == "help queue export html" then puts help_export_html
    when  input.join(" ") == "help queue save to"     then puts help_save_to_csv
    else puts "thats not the proper"
    end
  end

  def  queue_commands(commands)
    case
    when commands.length == 2 && commands.last == "count"
     return puts "The queue count is #{@queue.count}"
    when commands.length == 2 && commands.last == "clear"
      @queue.clear
     return puts "The queue has been cleared your highness"
    when commands.length == 2 && commands.last == "district"
     return puts "We just pinged sunlightfoundation for the districs, they've been loaded apporiately"
    when commands.length == 2 && commands.last == "print"
     puts "Check out my dope terminal-table, its so meta"
     @queue.print
    when commands[1] == "print" && commands[2] == "by"
     @queue.print_by(commands[3])
    when commands[1] == "save" && commands[2] == "to"
     @queue.save_to(commands.last)
     return puts "You file has been saved to #{commands.last}.csv"
    when commands[1] == "export" && commands[2] == "html"
     @queue.write_to_html(commands.last)
     return puts "You file has been saved to #{commands.last}.html"
    else
       puts "thats not a valid queue command"
       puts help_list
    end
  end
end
