# Minimal Weather App

This is a minimal weather app written in Rails 7 and React. It uses OpenWeatherMap to get current weather data and displays it. It also saves the weather data by postal code so that it will use it as a cache if it was saved within the last 30 minutes.


## Installation / Running in Dev

You can install it and run it by doing the following commands:

    bundle install
    yarn install
    rake db:create && rake db:migrate
    bin/dev
You also need to create an **.env** file and paste in the API key from OpenWeatherMap.

## Running Tests
There are Rspec tests, you can run them by running:
    
    rspec .