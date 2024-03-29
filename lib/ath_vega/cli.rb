# CLI Controller

class CLI


    def list_categories # lists categories as hash w/ index for use in menu
        categories = {}
        API.new.get_category_objects.each.with_index { |cat, idx| categories[:"#{cat.muscle}"] = idx  }
        categories.shift
        categories
    end

    def selected_category(user_category_selection)
        API.new.get_category_objects[user_category_selection] #receives index location and returns object instance from array of instances in Category class
    end

    def prompt
        prompt = TTY::Prompt.new
    end

    def category_menu
        cat_obj = selected_category(prompt.select("Select muscle group to see exercises", list_categories, cycle:true)) # menu to select muscle category. It returns index value to get instance of category from Category class array
    end

    def selected_exercise(user_exercise_selection)
        get_exercise_objects[user_exercise_selection] #receives index location and returns object instance from array of instances in Category class
    end

    def abs_cat_object
        abs_obj = Category.all[0]
    end

    def abs_exercise_items(abs_obj)
        ab_exercises = {}
        abs_obj.get_exercises.each.with_index { |exr, idx| ab_exercises[:"\n#{exr.name}\n#{exr.description}"] = idx }
        ab_exercises
    end

    def abs_menu
        abs_obj = abs_cat_object
        abs_exr = API.new.get_exercise_for_cat(abs_obj, prompt.select("Select an ab exercise", abs_exercise_items(abs_obj), cycle:true))
    end

    def list_items(cat_obj) # takes instance of Category class as argument, and returns list of exercises that belong to it
        exercises = {}
        cat_obj.get_exercises.each.with_index { |exr, idx| exercises[:"#{exr.name}\n#{exr.description}"] = idx }
        exercises
    end

    def exercise_menu(cat_obj) # takes value of user_selection variable returned from category_menu method as argument
        exr_obj = API.new.get_exercise_for_cat(cat_obj, prompt.select("Select an exercise to add to your workout", list_items(cat_obj), cycle:true))
    end

    def show_workout(workout_session)
        exr_group_1 = TTY::Table.new(["Session Exercises:", "Group 1: #{workout_session.session_exercises[0].name} \/ #{workout_session.session_exercises[1].name}","Group 2: #{workout_session.session_exercises[2].name} \/ #{workout_session.session_exercises[3].name}", "Group 3: #{workout_session.session_exercises[4].name}"], [["set/reps:", " ", " ", " "]])
        puts exr_group_1.render :unicode
    end

    def start
        title = TTY::Font.new(:starwars)
        title_color = Pastel.new
            puts "
                  ∎
                 ∎∎∎
                ∎∎∎∎∎
                |   |
                ∎∎∎∎∎  
                ∎∎∎∎∎ 
            "
            puts "Ivory Tower Studios presents..."
            sleep 2
            puts title_color.red(title.write("ATH"))
            puts "THE NINJA WORKOUT APP"
            puts title_color.blue(title.write("VEGA"))
            puts "\nbuilt with the open source wger app"
            sleep 1
            puts "Let's get started!"
    end

    def api_call
        vega_api = API.new
    end

    def create_session(vega_api)
        new_workout_session = vega_api.create_workout
    end

    def create_objects(vega_api)
        vega_api.call_data
    end

    def call
        start
        vega_api = api_call
        new_workout_session = vega_api.create_workout
        create_objects(vega_api)
        binding.pry
        prompt
        while new_workout_session.session_exercises.length < 4
            cat_obj = nil
            exr_obj = nil
            cat_obj = category_menu
            exr_obj = exercise_menu(cat_obj)
            exr_obj.workout = new_workout_session
        end
        puts "\nNow select your ab exercise"
        puts "\n"
        ab_exr = abs_menu
        ab_exr.workout = new_workout_session
        new_workout_session.set_exercise_array
        show_workout(new_workout_session)
    end 
end