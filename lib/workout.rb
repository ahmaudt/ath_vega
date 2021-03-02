class Workout
    attr_accessor :id, :creation_date, :comments, :workout_hash

    @@all = []
    

    def initialize(id, comments=nil, creation_date=Time.new.strftime("%Y-%m-%d"))
        @id = id
        @comments = comments
        @creation_date = creation_date
        @@all << self
        @workout_hash = self.hash_workout
        # @workout_hash["results"][:comments] << comments
        # @workout_hash["results"][:creation_date] << creation_date
    end

    def hash_workout
        workout_hash = Hash.new
        workout_hash = {:id => id, :comments => comments, :creation_date => creation_date}
    end

    def self.all
        @@all
    end

    def delete_current_workout
        self.all.delete_at(-1)
    end

    def add_selected_to_current_workout(exr)
        exr.workout = self
    end

    def get_exercises
        Exercise.all.select { |exr| exr.workout == self }
    end

    def exercises_names
        exercises.map { |exr| exr.name }
    end
end