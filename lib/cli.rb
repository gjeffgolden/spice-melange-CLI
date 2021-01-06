ActiveRecord::Base.logger = nil

class Cli

    def prompt
        TTY::Prompt.new(active_color: :on_red)
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
        Mixer.all.pluck("name")
    end

    def get_name
        puts "Cheers! Welcome to Spice Melange. What's your name, traveler?"
        @name = gets.chomp
    end

    def welcome_prompt_choices
        ["View Menu", "Order Special of the Day", "Create Your Own Drink"]
    end

    def welcome_prompt
        initial_selection = prompt.select("Welcome, #{@name}. What would you like to do?", welcome_prompt_choices)
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
        clear
        puts "Enjoy your: #{selected_beverage}."
    end
    
    def choose_alcohol_prompt
        clear
        liquor = prompt.select("Choose your liquor:", alcohol_names)
        mixer = prompt.select("Choose your mixer:", mixer_names)
        add_liquor = Alcohol.all.find_by name: liquor
        add_mixer = Mixer.all.find_by name: mixer
        drink = Beverage.create name: "#{@name}'s Drink", alcohol_id: add_liquor.id, mixer_id: add_mixer.id
        puts "Here you go! Enjoy your #{drink.name}: #{drink.alcohol.name} mixed with #{drink.mixer.name}."
    end

    def order_special
        clear
        puts "You've been eaten by a Giant Arrakian Sandworm!"
    end

    def start
        clear
        get_name
        clear
        welcome_prompt
    end

    def exit_app
        puts "Thanks for visiting Spice Melange!"
    end

end