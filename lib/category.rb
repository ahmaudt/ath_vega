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

    def self.list_muscle_categories
        category_menu = {}
        @@all_categories.each.with_index(1) { |cat, idx| category_menu[:"#{cat.muscle}"] = idx  } # "#{idx}. #{cat.muscle}" }
        category_menu
    end

    # def self.list_muscle_categories
    #     category_menu = {}
    #     @@all_categories.each do |cat|
    #         menu << "#{cat.muscle}"
    #     end
    # end

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

    def self.set_exercises # sets what category instance of exercise object belongs to
        exercise_menu = {}
        self.all.each do |category|
            Exercise.all.select do |exr|
                if category.muscle == exr.muscle
                    exr.category = category
                end
            end
        end
    end

    def get_exercises # gets exercises belonging to an instance of category
        Exercise.all.select { |exr| exr.category == self }
    end

    def self.get_exercises_by_category(user_input)
        exercise_menu = {}
        index = user_input - 1
        i = 1
        muscle_group = self.all[index].muscle
        Exercise.all.each.with_index do |exr, idx|
            if exr.muscle == muscle_group
                exercise_menu[:"#{i}. #{exr.name}\n#{exr.description}"] = idx
                i += 1
            end
        end
        exercise_menu
    end

    def workouts
        get_exercises.map { |exr| exr.workout }
    end

end