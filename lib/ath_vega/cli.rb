# CLI Controller

class CLI

    EXR_PATH = "https://wger.de/api/v2/exercise/?limit=227&language=2"
    EXR_CAT_PATH = "https://wger.de/api/v2/exercisecategory/?language=2&format=json"
    EXR_AUTH = "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab"
    EXR_WORKOUT = 'https://wger.de/api/v2/workout/?format=json'
    EXR_MAKE_WRKOUT = 'https://wger.de/api/v2/workout/?format=json'

    def get_last_workout_id
        workout = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X GET https://wger.de/api/v2/workout/?format=json`
        workout = JSON.parse(workout)
        if workout["results"].to_a.length == 0
            last_id = 258370
        else
            last_id = workout["results"].to_a.last["id"]
        end
    end

    def create_workout
        last_id = get_last_workout_id
        new_workout_id = last_id + 1
        new_workout = Workout.new(new_workout_id)
        send_workout = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X POST --data "{ "id": #{new_workout.id}, "creation_date": #{new_workout.creation_date}, "comments": #{new_workout.comments} }" https://wger.de/api/v2/workout/?format=json`
        new_workout
    end

    def get_exercises
        exr_list = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X GET "https://wger.de/api/v2/exercise/?limit=227&language=2"`
        exr_list = JSON.parse(exr_list)
    end
    
    def get_categories
        exr_cat = `curl --silent -H "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab" -X GET "https://wger.de/api/v2/exercisecategory/?language=2&format=json"`
        exr_cat = JSON.parse(exr_cat)
    end

    def call_api
        get_exercises
        get_categories
    end

    def create_categories
        exr_cat = get_categories
        exr_cat["results"].each do |cat|
            category = Category.new
            category.muscle = cat["name"]
        end
    end

    def create_exercises
        exr_cat = get_categories
        exr_list = get_exercises
        exr_list["results"].each do |idx|
            new_exercise = Exercise.new
            exr_cat["results"].each do |val|
                #! set key category equal to value of category in other hash
                if idx["category"] == val["id"] && idx["language"] == 2 && idx["description"] != ""
                    new_exercise.muscle = val["name"]
                    new_exercise.name = idx["name"]
                    new_exercise.description = "#{idx["description"][/\b(?<=<p>).*(?=<\/p>)/]}".insert(0, "\u{1F3CB} ")
                end
            end
        end
        Category.set_exercises
    end

    def get_category_objects
        # Category.list_muscle_categories
        Category.all
    end

    def get_exercise_objects
        Exercise.all
    end

    def list_categories # lists categories as hash w/ index for use in menu
        categories = {}
        get_category_objects.each.with_index { |cat, idx| categories[:"#{cat.muscle}"] = idx  }
        categories
    end

    def selected_category(user_category_selection)
        get_category_objects[user_category_selection] #receives index location and returns object instance from array of instances in Category class
    end

    def prompt
        prompt = TTY::Prompt.new
    end

    def category_menu
        cat_obj = selected_category(prompt.select("Select muscle group to see exercises", list_categories, cycle:true)) # menu to select muscle category. It returns index value to get instance of category from Category class array
    end

    def list_items(cat_obj) # takes instance of Category class as argument
        exercises = {}
        cat_obj.get_exercises.each.with_index { |exr, idx| exercises[:"#{exr.name}\n#{exr.description}"] = idx }
        exercises
    end

    def selected_exercise(user_exrcise_selection)
        get_exercise_objects[user_exrcise_selection] #receives index location and returns object instance from array of instances in Category class
    end

    def exercise_menu(cat_obj) # takes value of user_selection variable returned from category_menu method as argument
        exr_obj = selected_exercise(prompt.select("Select an exercise to add to your workout", list_items(cat_obj), cycle:true))
    end

    def build_workout_menu(new_workout)
        cat_obj = category_menu
        exr_obj = exercise_menu(cat_obj)
        puts "\nYou selected: " + "#{exr_obj.name}"
        add_exr = prompt.yes?("Want to add this exercise to your workout?")
        if add_exr == true
            exr_obj.workout = new_workout
        end
        new_workout.get_exercises
    end

    def start
            puts "
                  ∎
                 ∎∎∎
                ∎∎∎∎∎
                |   |
                ∎∎∎∎∎ Ivory Tour 
                ∎∎∎∎∎ Studios presents...
            "
            sleep 1
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
    def call
        new_workout = create_workout
        start
        create_categories
        create_exercises
        prompt
        build_workout_menu(new_workout)
        binding.pry
    end 
end