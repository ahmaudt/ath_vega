class Workout
    attr_accessor :name

    @@all_workouts = []
    def initialize
        @name = name
        @@all_workouts << self
    end

    def self.all
        @@all_workouts
    end

    def this_workout_exercises
        Exercise.all.select { |exr| exr.workout == self }
    end

    def exercises_names
        exercises.map { |exr| exr.name }
    end
end