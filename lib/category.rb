class Category
    attr_accessor :muscle, :exercises

    @@all_categories = []
    def initialize
        @muscle = muscle
        @@all_categories << self
    end

    def self.all
        @@all_categories
    end

    def self.set_exercises # sets what category instance of exercise object belongs to
        self.all.each do |category|
            Exercise.all.select do |exr|
                if category.muscle == exr.muscle
                    exr.category = category
                end
            end
        end
    end

    def get_exercises # gets exercises belonging to an instance of Category
        Exercise.all.select { |exr| exr.category == self }
    end

    def self.get_exr_by_cat(user_input)
        selected_category = self.all[user_input]
        selected_category.get_exercises
    end

end