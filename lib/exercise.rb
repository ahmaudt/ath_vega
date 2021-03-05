class Exercise # exercise belongs to a category
    attr_accessor :name, :muscle, :description, :workout, :category

    @@all_exercises = []

    def initialize
        @name = name
        @muscle = muscle # each instance of exercise will set its muscle equal to instance of muscle category
        @description = description
        @@all_exercises << self
    end

    def self.all
        @@all_exercises
    end
end