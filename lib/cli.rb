ActiveRecord::Base.logger = nil

class Cli

    def prompt
        TTY::Prompt.new
    end

    def clear
        system("clear")
    end

    def drink_list
        Beverage.all.pluck("name")
    end

    def menu
        clear
        prompt.select("What'll it be?", drink_list)
    end

    def alcohol_list
        Alcohol.all.pluck("name")
    end

    def welcome_menu
        ["View Menu", "Order Special of the Day", "Create Your Own Drink"]
    end

    def create_drink_menu
        clear
        prompt.multi_select("Choose your liquors:", alcohol_list)
    end

    def order_special
        clear
        puts "You've been eaten by the Arrkarian worm!"
    end

    def welcome
        clear
        puts "Cheers! Welcome to Spice Melange. What's your name, traveler?"
        name = gets.chomp
        initial_selection = prompt.select("Have a seat, #{name}. What would you like to do?", welcome_menu)
        if initial_selection == welcome_menu[0]
            menu
        end
        if initial_selection == welcome_menu[1]
            order_special
        end
        if initial_selection == welcome_menu[2]
            create_drink_menu
        end
    end

end