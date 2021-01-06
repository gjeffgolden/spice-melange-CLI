ActiveRecord::Base.logger = nil

class Cli

    def prompt
        TTY::Prompt.new
    end

    def clear
        system("clear")
    end

    def beverage_names
        Beverage.all.pluck("name")
    end

    def alcohol_names
        Alcohol.all.pluck("name")
    end

    def mixer_names
        Alcohol.all.pluck("name")
    end

    def get_name
        puts "Cheers! Welcome to Spice Melange. What's your name, traveler?"
        @name = gets.chomp
    end

    def welcome_prompt_choices
        ["View Menu", "Order Special of the Day", "Create Your Own Drink"]
    end

    def welcome_prompt
        clear
        initial_selection = prompt.select("Have a seat, #{@name}. What would you like to do?", welcome_prompt_choices)
        if initial_selection == welcome_prompt_choices[0]
            menu_prompt
        end
        if initial_selection == welcome_prompt_choices[1]
            order_special
        end
        if initial_selection == welcome_prompt_choices[2]
            choose_alcohol_prompt
        end
    end

    def menu_prompt
        clear
        selected_beverage = prompt.select("What'll it be?", beverage_names)
        user_favorites << selected_beverage
        clear
        puts "Enjoy your: #{selected_beverage}."
    end

    def choose_alcohol_prompt
        clear
        prompt.multi_select("Choose your liquors:", alcohol_names)
    end

    def order_special
        clear
        puts "You've been eaten by the Arrkarian worm!"
    end

    def start
        clear
        get_name
        welcome_prompt
        puts "Thanks for visiting Spice Melange!"
    end

end