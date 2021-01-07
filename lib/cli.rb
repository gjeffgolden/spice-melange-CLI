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
        @pastel = Pastel.new
        font = TTY::Font.new(:starwars)
        puts @pastel.bright_magenta(font.write("Spice Melange"))
    end

    def pause
        puts @pastel.bold("(Press Enter to Return to Main Menu)")
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
        puts @pastel.cyan("Cheers! Welcome to Spice Melange. What's your name, traveler?")
        @name = gets.chomp
    end

    def print_tab
        names = @user_tab.beverages.map {|bev| bev.name}
        reset
        puts @pastel.cyan("Here's what you've had so far:")
        puts names
        pause
        welcome_prompt
    end

    def welcome_prompt_choices
        ["View Menu", "Create Your Own Drink", "Special of the Day", "My Tab", "Get on a spaceship byeeeeeeeeeeee"]
    end

    def welcome_prompt
        reset
        initial_selection = prompt.select(@pastel.cyan("Hello, #{@name}. What'll it be?"), welcome_prompt_choices)
        if initial_selection == welcome_prompt_choices[0]
            menu_prompt
        end
        if initial_selection == welcome_prompt_choices[1]
            choose_alcohol_prompt
        end
        if initial_selection == welcome_prompt_choices[2]
            order_special
        end
        if initial_selection == welcome_prompt_choices[3]
            print_tab
        end
        if initial_selection == welcome_prompt_choices[4]
            exit_app
        end
    end

    def menu_prompt
        reset
        selected_beverage = prompt.select(@pastel.cyan("Here's our menu:"), original_beverage_names)
        reset
        @user_tab.beverages << Beverage.all.find {|bev| bev.name = selected_beverage}
        progress_bar
        puts @pastel.cyan("Enjoy your: #{selected_beverage}.")
        pause
        welcome_prompt
    end
    
    def choose_alcohol_prompt
        reset
        liquor = prompt.select(@pastel.cyan("Choose your liquor:"), alcohol_names)
        reset
        mixer = prompt.select(@pastel.cyan("Choose your mixer:"), mixer_names)
        add_liquor = Alcohol.all.find_by name: liquor
        add_mixer = Mixer.all.find_by name: mixer
        drink = Beverage.new name: "#{@name}'s Drink", alcohol_id: add_liquor.id, mixer_id: add_mixer.id
        @user_tab.beverages << drink
        reset
        progress_bar
        puts @pastel.cyan("Survival is the ability to swim in strange water. Enjoy your #{drink.name}: #{drink.alcohol.name} mixed with #{drink.mixer.name}.")
        pause
        welcome_prompt
    end

    def order_special
        reset
        progress_bar
        puts @pastel.cyan("The Special of the Day is ... DEATH! Speak the name of Dune's author to save yourself.")
        answer = gets
        if answer.include?("Herbert")
            reset
            puts @pastel.cyan("YOU ARE WORTHY!")
            pause
            welcome_prompt
        else
            reset
            puts @pastel.cyan("You've been eaten by a Giant Arrakian Sandworm. Goodbye.")
        end
    end

    def start
        reset
        get_name
        @user_tab = Tab.new name: "#{@name}'s Tab"
        reset
        welcome_prompt
    end

    def exit_app
        reset
        puts @pastel.cyan("Thanks for visiting Spice Melange. Fear is the mind-killer. Fear is the little-death that brings total obliteration.")
    end

end