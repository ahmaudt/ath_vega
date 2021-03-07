class Workout
    attr_accessor :id, :creation_date, :comments, :workout_hash

    @@all = []
    @exercises = []
    

    def initialize(id, comments=nil, creation_date=Time.new.strftime("%Y-%m-%d"))
        @id = id
        @comments = comments
        @creation_date = creation_date
        @@all << self
        @exercises = []
        @workout_hash = self.hash_workout
    end

    def hash_workout
        workout_hash = Hash.new
        workout_hash = {:id => id, :comments => comments, :creation_date => creation_date}
    end

    def self.all
        @@all
    end

    def add_selected_to_current_workout(exr)
        exr.workout = self
    end

    def session_exercises
        @exercises = Exercise.all.select { |exr| exr.workout == self }
    end

    def set_exercise_array
        exercises = self.session_exercises
        match = self.session_exercises.find { |exr| exr.muscle == "Abs" }
        match_index = self.session_exercises.index(match)
        exercises = exercises.insert(-1,exercises.delete_at(match_index))
    end
end