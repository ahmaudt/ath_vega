# CLI Controller

class CLI

    def list_categories # lists categories as hash w/ index for use in menu
        categories = {}
        API.new.get_category_objects.each.with_index { |cat, idx| categories[:"#{cat.muscle}"] = idx  }
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

    def list_items(cat_obj) # takes instance of Category class as argument, and returns list of exercises that belong to it
        exercises = {}
        cat_obj.get_exercises.each.with_index { |exr, idx| exercises[:"#{exr.name}\n#{exr.description}"] = idx }
        exercises
    end

    def selected_exercise(user_exrcise_selection)
        get_exercise_objects[user_exrcise_selection] #receives index location and returns object instance from array of instances in Category class
    end

    def exercise_menu(cat_obj) # takes value of user_selection variable returned from category_menu method as argument
        exr_obj = API.new.get_exercise_for_cat(cat_obj, prompt.select("Select an exercise to add to your workout", list_items(cat_obj), cycle:true))
    end

    def show_workout(workout_session)
        table = TTY::Table.new(["Session Exercises:", "#{workout_session.session_exercises[2].name}","#{workout_session.session_exercises[1].name}", "#{workout_session.session_exercises[0].name}"], [["Set/Reps:", "", "", ""]])
        puts table.render :unicode
    end

    def start
            puts "
                  ∎
                 ∎∎∎
                ∎∎∎∎∎
                |   |
                ∎∎∎∎∎  
                ∎∎∎∎∎ Ivory Tower Studios presents...
            "
            sleep 2
            puts "ATH 'vega' the workout app for ninjas."
            puts "\n(built on the open source 'wger' platform)"
            sleep 1
            Catpix::print_image "./lib/ninja-gaiden.png",
            :limit_x => 0.15,
            :limit_y => 0,
            :center_x => false,
            :center_y => false,
            :bg => "white",
            :bg_fill => false
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
        prompt
        while new_workout_session.session_exercises.length < 3
            cat_obj = nil
            exr_obj = nil
            cat_obj = category_menu
            exr_obj = exercise_menu(cat_obj)
            exr_obj.workout = new_workout_session
        end
        show_workout(new_workout_session)
    end 
end