# Flatiron School Mod 1 Pair Project
## Louis Leffler and Jeff Golden

## Description

SPICE MELANGE is a CLI app that creates a virtual Dune-themed cantina. While in this otherworldly watering hole, users can order a drink, create their own drink, answer Dune trivia, dodge giant sandworms, and view their tab (including total cost in solari credits). At the very least, you'll leave with some fancy new Dune quotes to impress your friends.

## Features

This CLI app uses four classes, all created using ActiveRecord migrations: 'Mixer', 'Alcohol', and 'Tab', all joined together through 'Beverage'. Using these associations, a user can:

1. Choose from a pre-seeded list of Beverages (the menu).
2. Create their own Beverage by specifying a Mixer and an Alcohol.
3. Get a *surprise* when ordering the Special of the Day.
4. View their Tab, including the name of each Beverage they've selected or created along with the total cost in solari credits.
5. Exit the app.

## Challenges and Lessons

1. GitHub Workflow. It was the first time for both of us collaborating using GitHub, and the first step of the entire project was learning how to work with branches and pull requests. With more than 20 commits under our belts now, it's all starting to make a little more sense.
2. Installing and initializing extra Ruby gems. Lots of doors were unlocked here!
3. Using ActiveRecord to establish Class relationships. Understanding the functional difference between 'Class.create' and 'Class.new' was one of many a-ha! moments. It was also fun getting 'tab.beverages' to work exactly as needed.

## Gems Used

1. tty-pastel
2. tty-prompt
3. tty-color
4. tty-progressbar
5. ActiveRecord
6. Rake
7. Pry (lots and lots and lots of Pry)