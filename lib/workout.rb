class Workout
    attr_accessor :id, :creation_date, :comments, :workout_hash

    @@all = []
    

    def initialize(id, comments=nil, creation_date=Time.new.strftime("%Y-%m-%d"))
        @id = id
        @comments = comments
        @creation_date = creation_date
        @@all << self
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
        Exercise.all.select { |exr| exr.workout == self }
    end
end