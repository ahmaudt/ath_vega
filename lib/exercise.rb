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

    def self.exercise_selected_by_user(user_input)
        index = user_input - 1
        selected_exercise = nil
        selected_exercise = self.all[index]
        # self.all.select do |exr|
        #     if exr.name  == selected_exercise
        #         selected_exercise = exr
        #     end
        # end
        # selected_exercise
    end
end