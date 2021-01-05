ActiveRecord::Base.logger = nil

class Cli

    def prompt
        TTY::Prompt.new
    end

    def welcome
        system("clear")
        puts "Cheers! Welcome to Spice Melange. What's your name, traveler?"
    end


end