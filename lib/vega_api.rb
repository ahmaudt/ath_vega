class API
    EXR_PATH = "https://wger.de/api/v2/exercise/?limit=227&language=2"
    EXR_CAT_PATH = "https://wger.de/api/v2/exercisecategory/?language=2&format=json"
    EXR_AUTH = "Authorization: Token 7f49dbc8baed11960d576e35b45fe34c060eaeab"
    EXR_WORKOUT = 'https://wger.de/api/v2/workout/?format=json'
    EXR_MAKE_WRKOUT = 'https://wger.de/api/v2/workout/?format=json'

    def initialize
        
    end

    def get_exercises
        exr_list = `curl --silent -H "#{EXR_AUTH}" -X GET "#{EXR_PATH}"`
        exr_list = JSON.parse(exr_list)
    end
    
    def get_categories
        exr_cat = `curl --silent -H "#{EXR_AUTH}" -X GET "#{EXR_CAT_PATH}"`
        exr_cat = JSON.parse(exr_cat)
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

    def call_data
        bar = TTY::ProgressBar.new("getting workout data... [:bar]", total: 40)
        create_categories
        create_exercises
        40.times do
            sleep(0.2)
            bar.advance  # by default increases by 1
        end
    end

    def get_category_objects
        Category.all
    end

    def get_exercise_for_cat(cat_obj, index)
        cat_obj.get_exercises[index]
    end

    def get_last_workout_id
        workout = `curl --silent -H "#{EXR_AUTH}" -X GET "#{EXR_WORKOUT}"`
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
        send_workout = `curl --silent -H "#{EXR_AUTH}" -X POST --data "{ "id": #{new_workout.id}, "creation_date": #{new_workout.creation_date}, "comments": #{new_workout.comments} }" "#{EXR_WORKOUT}"`
        new_workout
    end

end