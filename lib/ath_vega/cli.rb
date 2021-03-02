# CLI Controller
require 'net/http'
require 'uri'
require 'open-uri'
require 'awesome_print'
require 'json'
require 'nokogiri'
require 'pry'

require_relative '../exercise.rb'
require_relative '../category.rb'
require_relative '../workout.rb'



class CLI

    EXR_PATH = "https://wger.de/api/v2/exercise/?limit=227&language=2"
    EXR_CAT_PATH = "https://wger.de/api/v2/exercisecategory/?language=2&format=json"
    EXR_AUTH = "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab"
    EXR_WORKOUT = 'https://wger.de/api/v2/workout/?format=json'
    EXR_MAKE_WRKOUT = 'https://wger.de/api/v2/workout/?format=json'

    def get_last_workout_id
        workout = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X GET https://wger.de/api/v2/workout/?format=json`
        workout = JSON.parse(workout)
        if workout["results"].to_a.length == 0
            last_id = 258370
        else
            last_id = workout["results"].to_a.last["id"]
        end
    end

    def create_workout
        last_id = get_last_workout_id
        new_workout_id = last_id + 1
        new_workout = Workout.new(new_workout_id)
        send_workout = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X POST --data "{ "id": #{new_workout.id}, "creation_date": #{new_workout.creation_date}, "comments": #{new_workout.comments} }" https://wger.de/api/v2/workout/?format=json`
        new_workout
    end

    def get_exercises
        exr_list = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X GET "https://wger.de/api/v2/exercise/?limit=227&language=2"`
        exr_list = JSON.parse(exr_list)
    end
    
    def get_categories
        exr_cat = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X GET "https://wger.de/api/v2/exercisecategory/?language=2&format=json"`
        exr_cat = JSON.parse(exr_cat)
    end

    def call_api
        get_exercises
        get_categories
    end

    def create_categories
        exr_cat = get_categories
        exr_cat["results"].each do |cat|
            category = Category.new
            category.muscle = cat["name"]
        end
    end

    def create_exercises
        exr_cat = get_categories
        exr_list = get_exercises
        exr_list["results"].each do |idx|
            new_exercise = Exercise.new
            exr_cat["results"].each do |val|
                #! set key category equal to value of category in other hash
                if idx["category"] == val["id"] && idx["language"] == 2 && idx["description"] != ""
                    new_exercise.muscle = val["name"]
                    new_exercise.name = idx["name"]
                    new_exercise.description = "#{idx["description"][/\b(?<=<p>).*(?=<\/p>)/]}".insert(0, "\u{1F3CB} ")
                end
            end
        end
    end

    def num_input 
        gets.chomp.to_i
    end

    def string_input
        gets.strip.downcase
    end

    def list_categories
        Category.list_muscle_categories
    end

    def list_exercise_in_category(user_input)
        Category.get_exercises_by_category(user_input)
    end

    def select_exercise(exercises, user_input)
        # get index of object in array of exercise objects returned from last method
        index = user_input - 1
        selected_exercise = exercises[index]
        print "\nYou selected: " + exercises[index].name
        selected_exercise
    end

    def build_workout(new_workout)
        while new_workout.get_exercises.length < 3
            input = nil
            # list muscle categories
            puts "\n"
            list_categories
            puts "Enter number of muscle group to see associated exercises"
            input  = num_input
            # select muscle category to see exercises
            exercises = Category.get_exercises_by_category(input)
            puts "\nenter number to add exercise to workout"
            input = num_input
            # return exercises based on input and add it to workout
            chosen_exercise = select_exercise(exercises, input)
            chosen_exercise.workout = new_workout # add selected exercise to workout
        end
    end

    def call
        puts "Welcome to Ath, the workout app for ninjas! (built on the 'wger' platform)" # welcome user
        # fetch API data and create workout object
        new_workout = create_workout
        puts "\nOkay, let's build  your workout!"
        # get api data and instantiate objects
        create_categories
        create_exercises
        build_workout(new_workout)
        puts "\nYour workout is set."
        puts "\nLet's start training so we can get back out there and fight crime. Remember, evil never rests!"
        # starts workout and shows first exercise
    end 
end