ActiveRecord::Base.logger = nil

class Cli

    def prompt
        TTY::Prompt.new(active_color: :bright_magenta)
    end

    def progress_bar
        bar = TTY::ProgressBar.new("Mixing ... [:bar]", total: 20)
        20.times do
            sleep(0.1)
            bar.advance(1)
        end
    end

    def reset
        system("clear")
        pastel = Pastel.new
        font = TTY::Font.new(:starwars)
        puts pastel.bright_magenta(font.write("Spice Melange"))
    end

    def pause
        puts "(Press Enter to Return to Main Menu)"
        gets
    end

    def original_beverage_names
        Beverage.all.pluck("name").slice(0,7)
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
        ["View Menu", "Order Special of the Day", "Create Your Own Drink", "Get on a spaceship byeeeeeeeeeeee"]
    end

    def welcome_prompt
        reset
        initial_selection = prompt.select("Hello, #{@name}. What'll it be?", welcome_prompt_choices)
        if initial_selection == welcome_prompt_choices[0]
            menu_prompt
        end
        if initial_selection == welcome_prompt_choices[1]
            order_special
        end
        if initial_selection == welcome_prompt_choices[2]
            choose_alcohol_prompt
        end
        if initial_selection == welcome_prompt_choices[3]
            exit_app
        end
    end

    def menu_prompt
        reset
        selected_beverage = prompt.select("Here's our menu:", original_beverage_names)
        reset
        progress_bar
        puts "Enjoy your: #{selected_beverage}."
        pause
        welcome_prompt
    end
    
    def choose_alcohol_prompt
        reset
        liquor = prompt.select("Choose your liquor:", alcohol_names)
        reset
        mixer = prompt.select("Choose your mixer:", mixer_names)
        add_liquor = Alcohol.all.find_by name: liquor
        add_mixer = Mixer.all.find_by name: mixer
        drink = Beverage.create name: "#{@name}'s Drink", alcohol_id: add_liquor.id, mixer_id: add_mixer.id
        reset
        progress_bar
        puts "Survival is the ability to swim in strange water. Enjoy your #{drink.name}: #{drink.alcohol.name} mixed with #{drink.mixer.name}."
        pause
        welcome_prompt
    end

    def order_special
        reset
        progress_bar
        puts "You've been eaten by a Giant Arrakian Sandworm!"
    end

    def start
        reset
        get_name
        reset
        welcome_prompt
    end

    def exit_app
        reset
        puts "Thanks for visiting Spice Melange. Fear is the mind-killer. Fear is the little-death that brings total obliteration."
    end

end