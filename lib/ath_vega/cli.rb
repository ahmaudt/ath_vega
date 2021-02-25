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
    EXR_AUTH = 'Authorization: Token b4f793084a9c3739e59c086cf2914ec69e5b1a25'
    
    def get_exercises
        exr_list = `curl --silent -H #{EXR_AUTH} -X GET #{EXR_PATH} `
        exr_list = JSON.parse(exr_list)
    end
    
    def get_categories
        exr_cat = `curl --silent  -H #{EXR_AUTH} -X GET #{EXR_CAT_PATH}`
        exr_cat = JSON.parse(exr_cat)
    end

    def create_category_objects
        exr_cat = get_categories
        exr_cat["results"].each do |cat|
            category = Category.new
            category.muscle = cat["name"]
        end
    end

    def create_exercise_objects
        exr_cat = get_categories
        exr_list = get_exercises
        exr_list["results"].each do |idx|
            new_exercise = Exercise.new
            exr_cat["results"].each do |val|
                #! set key category equal to value of category in other hash
                if idx["category"] == val["id"] && idx["language"] == 2 && idx["description"].empty? == false
                    new_exercise.muscle = val["name"]
                    new_exercise.name = idx["name"]
                    new_exercise.description = "#{idx["description"][/\b(?<=<p>).*(?=<\/p>)/]}".insert(0, "\u{1F3CB} ")
                end
            end
        end
    end

    def create_workout
        create_category_objects
        create_exercise_objects
        new_workout = Workout.new
    end


    def self.ask_for_input 
        gets.chomp.to_i
    end

    def call
        # call on api and pull all the data you need to create objects
        puts "\nWelcome to Ath vega, the workout app for ninjas \u{1F977}."
        puts "Before we create a workout, let's go over a few tips."
        sleep 2
        puts "\nFirst, a good workout will focus on two major muscle groups and your core."
        sleep 2
        puts "\nSecond, you don't want overtrain (and yes, there is such a thing!)."
        sleep 2
        puts "\nSo, be careful when adding weight, sets, and reps."
        sleep 2
        puts "\nTo get started, three sets of 5-10 reps should be enough for each exercise."
        sleep 2
        puts "\nOkay, let's create your workout!"
        create_workout
        # binding.pry
        # TODO: add list_categories method to output list of muscle categories
        Category.list_muscle_categories
        # DONE: add input method to return all exercises for the corresponding number
        puts "\nEnter the corresponding number to see exercises for a muscle category."
        num = gets.chomp.to_i
        Category.get_exercises_by_category(num)
        # binding.pry
        puts "\nEnter number of exercises to add it to your workout: "
        num = gets.chomp.to_i
        # TODO: should return "you have selected #{name_of_workout}."
        
        # TODO: should set selected exercise's instance variable equal to current instance of workout
        # TODO: should send user back to main screen with the previously selected muscle group removed
    end 

end