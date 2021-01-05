ActiveRecord::Base.logger = nil

class Cli

    def prompt
        TTY::Prompt.new
    end

    def menu
        Beverage.all.pluck("name")
    end

    def welcome
        system("clear")
        puts "Cheers! Welcome to Spice Melange. What's your name, traveler?"
        name = gets.chomp
        prompt.select("Have a seat, #{name}. Would you like to see our menu, or create your own drink?", menu)
    end

end