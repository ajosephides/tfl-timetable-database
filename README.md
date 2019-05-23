# TFL timetable database creator
This is a little project to build a database of timetables from each stop to another on the London TFL tube network.
The goal was to practise some ruby, well learn - with the aim of using this database for another application.

The program uses the TFL api and so user credentials must be created.
Create a Module in the `api` folder called `secrets.rb` and initialise with 2 variables @APP_ID and @API_KEY

Before running for the first time make sure all dependencies are in place by running
```bundle install```

To run from base directory:
```ruby -I ./lib/ bin/main.rb```