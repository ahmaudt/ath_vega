require_relative './exercise.rb'

class Category
    attr_accessor :muscle

    @@all_categories = []
    def initialize
        @muscle = muscle
        @@all_categories << self
    end

    def self.all
        @@all_categories
    end

    def self.list_muscle_categories
        @@all_categories.each.with_index(1) { |cat, idx| puts "#{idx}. #{cat.muscle}" }
    end

    def self.get_exercises_by_category(user_input)
        #! the number is the index of the category object
        #! pulls category object
        #! iterate through category object to display all corresponding exercises
        index = user_input - 1
        i = 1
        muscle_group = self.all[index].muscle
        Exercise.all.select do |exr| 
            if exr.muscle == muscle_group #where number corresponds to muscle category object selected 
                puts "\n"
                puts "#{i}. #{exr.name}"
                puts "#{exr.description}"
                i += 1
            end
        end
    end

    def workouts
        get_exercises.map { |exr| exr.workout }
    end

end