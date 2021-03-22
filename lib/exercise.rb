class Exercise # exercise belongs to a category
    attr_accessor :name, :muscle, :description, :workout, :category

    @@all_exercises = []

    def initialize
        @name
        @muscle
        @description
        @@all_exercises << self
    end

    def self.get_all_muscles_ofX(muscle_cat)
        collected_muscles = []
        @@all_exercises.select { |exr| exr.muscle == muscle_cat }
    end

    def self.all
        @@all_exercises
    end
end