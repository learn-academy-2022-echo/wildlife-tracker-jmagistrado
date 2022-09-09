Wildlife Tracker Challenge
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

Story 1: In order to track wildlife sightings, as a user of the API, I need to manage animals.

Branch: animal-crud-actions

Acceptance Criteria

SETUP:
        cd desktop 
        rails db:create 
        rails new wild-tracker -d postgresql -T
        cd wild-tracker
        git remote add origin https://github.com/learn-academy-2022-echo/wildlife-tracker-jmagistrado.git
        code . 
        git add .
        git commit -m "Initial commit"
        git push origin main
        git checkout main
        git pull origin main
        git branch
        git checkout -b animal-crud-actions
        code . 
        bundle add rspec-rails
        rails generate rspec:install
        rails s
        Open folder in a text editor 


To generate resource: 
        $ rails generate resource Student name:string cohort:string 
        $ rails routes DONT FORGET TO SAVE ALL ROUTES OR ELSE 
        $ rails db:migrate

Create a resource for animal with the following information: common name and scientific binomial

   $rails generate resource Animal common_name:string scientific_binomial:string ✅
                  invoke  active_record
                    create    db/migrate/20220909003339_create_animals.rb
                    create    app/models/animal.rb
                    invoke  controller
                    create    app/controllers/animals_controller.rb
                    invoke    erb
                    create      app/views/animals
                    invoke    helper
                    create      app/helpers/animals_helper.rb
                    invoke  resource_route
                    route    resources :animals
   
   
   $rails routes -E ✅
                --[ Route 1 ]---------------------------------------------------------------------
                Prefix            | animals
                Verb              | GET
                URI               | /animals(.:format)
                Controller#Action | animals#index
                --[ Route 2 ]---------------------------------------------------------------------
                Prefix            | 
                Verb              | POST
                URI               | /animals(.:format)
                Controller#Action | animals#create
                --[ Route 3 ]---------------------------------------------------------------------
                Prefix            | new_animal
                Verb              | GET
                URI               | /animals/new(.:format)
                Controller#Action | animals#new
                --[ Route 4 ]---------------------------------------------------------------------
                Prefix            | edit_animal
                Verb              | GET
                URI               | /animals/:id/edit(.:format)
                Controller#Action | animals#edit
                --[ Route 5 ]---------------------------------------------------------------------
                Prefix            | animal
                Verb              | GET
                URI               | /animals/:id(.:format)
                Controller#Action | animals#show
                --[ Route 6 ]---------------------------------------------------------------------
                Prefix            | 
                Verb              | PATCH
                URI               | /animals/:id(.:format)
                Controller#Action | animals#update
                --[ Route 7 ]---------------------------------------------------------------------
                Prefix            | 
                Verb              | PUT
                URI               | /animals/:id(.:format)
                Controller#Action | animals#update
                --[ Route 8 ]---------------------------------------------------------------------
                Prefix            | 
                Verb              | DELETE
                URI               | /animals/:id(.:format)
                Controller#Action | animals#destroy
   $rails db:migrate ✅

    #delete the views folder ✅

Can see the data response of all the animals
    -Index is the requst to retrieve all instances created 

    $ rails c ✅
    > Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'✅
    >Animal.create common_name: 'Whale', scientific_binomial: 'Cetacea'✅
    > exit ✅

app/controller/animals_controller.rb ✅
 //Index - To see all instances 
``` ruby

    class AnimalsController < ApplicationController

    def index
        @animals = Animal.all 
        render json:animals 
    end
end

```
To check our index:  ✅
    $ rails s
    -open the Postman application
        HTTP verb: GET
        url: localhost3000/animals 

        //output: 
                [
                    {
                        "id": 1,
                        "common_name": "Dog",
                        "scientific_binomial": "Canis familiaris",
                        "created_at": "2022-09-09T04:45:15.831Z",
                        "updated_at": "2022-09-09T04:45:15.831Z"
                    },
                    {
                        "id": 2,
                        "common_name": "Whale",
                        "scientific_binomial": "Cetacea",
                        "created_at": "2022-09-09T05:12:19.270Z",
                        "updated_at": "2022-09-09T05:12:19.270Z"
                    }
                ]

Disable Authenticity Token:  ✅

app/controllers/application_controller.rb 

        class ApplicationController < ActionController::Base
            skip_before_action :verify_authenticity_token
        end

     
Can create a new animal in the database 

- To create a new instance in the database 
 -create stong params/private and a create block  ✅

app/controller/animals_controller.rb  ✅

```ruby
     def index
        animals = Animal.all 
        render json: animals 
    end
    def show
        animal = Animal.find(params[:id])
        render json: animal
    end
    def create 
        animal = Animal.create(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end
    private
    def animal_params
        params.require(:animal).permit(:common_name,:scientific_binomial)
    end
end


```
In postman:  ✅
        HTTP verb: POST 
        url: localhost:3000/animals
        choose "Body"
        choose "raw"
        choose "JSON"
        

     {
        "common_name":"Penguin",
        "scientific_binomial": "Spheniscidae"

    }

//output: 
            {
                "id": 3,
                "common_name": "Penguin",
                "scientific_binomial": "Spheniscidae",
                "created_at": "2022-09-09T05:34:40.258Z",
                "updated_at": "2022-09-09T05:34:40.258Z"
            }

//Made an incorrect spelling so I can update/patch this one! 
    {
        "common_name":"Jellyfsh",
        "scientific_binomial": "Aurelia aurita"

     }

//output:

            {
                "id": 4,
                "common_name": "Jellyfsh",
                "scientific_binomial": "Aurelia aurita",
                "created_at": "2022-09-09T05:42:44.400Z",
                "updated_at": "2022-09-09T05:42:44.400Z"
            }



Can update an existing animal in the database  ✅
- Update is to make changes to an already made istance 

app/controller/animals_controller.rb  ✅

```ruby
  def index
        animals = Animal.all 
        render json: animals 
    end
    def show
        animal = Animal.find(params[:id])
        render json: animal
    end
    def create 
        animal = Animal.create(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end
    def update
        animal = Animal.find(params[:id])
        animal.update(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
            end
    end
    private
    def animal_params
        params.require(:animal).permit(:common_name,:scientific_binomial)
    end
end
```
In Postman:  ✅
        HTTP verb: PATCH
        url: localhost:3000/animals/:id <--- this wil be the id # of specific instance
        choose "Body"
        choose "raw"
        choose "JSON"

Edit instance in Postman body with correction:  ✅

    {
        "common_name":"Jellyfsh",
        "scientific_binomial": "Aurelia aurita"

     }



//output: 

            {
                "common_name": "Jellyfish",
                "scientific_binomial": "Aurelia aurita",
                "id": 4,
                "created_at": "2022-09-09T05:42:44.400Z",
                "updated_at": "2022-09-09T05:45:02.291Z"
            }



Can remove an animal entry in the database  ✅
 -  The destroy action is the conventional Rails action for removing content from the database 

app/controller/animals_controller.rb  ✅

```ruby
  def index
        animals = Animal.all 
        render json: animals 
    end
    def show
        animal = Animal.find(params[:id])
        render json: animal
    end
    def create 
        animal = Animal.create(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end
    def update
        animal = Animal.find(params[:id])
        animal.update(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
            end
    end
    def destroy
     animal = Animal.find(params[:id])
        if animal.destroy
        render json: animal
        else
            render json: animal.errors
        end
    end
    private
    def animal_params
        params.require(:animal).permit(:common_name,:scientific_binomial)
    end
end
```


In Postman:  ✅
        HTTP verb: DELETE
        url: localhost:3000/animals/:id <--- this wil be the id # of specific instance that is to be deleted 
        choose "Body"
        choose "raw"
        choose "JSON"

In Postman Body: Should receive the item deleted  ✅

ex) 

DELETE localhost:3000/animals/5

//output: To be the instance you have deleted 

        {
            "id": 5,
            "common_name": "cellphone",
            "scientific_binomial": "Aurelia aurita",
            "created_at": "2022-09-09T05:56:37.245Z",
            "updated_at": "2022-09-09T05:56:37.245Z"
        }



Story 2: In order to track wildlife sightings, as a user of the API, I need to manage animal sightings.

Branch: sighting-crud-actions  ✅

Acceptance Criteria

Create a resource for animal sightings with the following information: latitude, longitude, date
Hint: An animal has_many sightings (rails g resource Sighting animal_id:integer ...)
Hint: Date is written in Active Record as yyyy-mm-dd (“2022-07-28")

$ rails generate migration sighting_migrate
$ rails generate resource Sighting animal_id:integer latitude:integer longitude:integer date:date


Can create a new animal sighting in the database


Can update an existing animal sighting in the database


Can remove an animal sighting in the database




Story 3: In order to see the wildlife sightings, as a user of the API, I need to run reports on animal sightings.

Branch: animal-sightings-reports

Acceptance Criteria

Can see one animal with all its associated sightings
Hint: Checkout this example on how to include associated records


Can see all the all sightings during a given time period
Hint: Your controller can use a range to look like this:

class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end

Hint: Be sure to add the start_date and end_date to what is permitted in your strong parameters method


Hint: Utilize the params section in Postman to ease the developer experience


Hint: Routes with params


Stretch Challenges
Story 4: In order to see the wildlife sightings contain valid data, as a user of the API, I need to include proper specs.

Branch: animal-sightings-specs

Acceptance Criteria
Validations will require specs in spec/models and the controller methods will require specs in spec/requests.

Can see validation errors if an animal doesn't include a common name and scientific binomial
Can see validation errors if a sighting doesn't include latitude, longitude, or a date
Can see a validation error if an animal's common name exactly matches the scientific binomial
Can see a validation error if the animal's common name and scientific binomial are not unique
Can see a status code of 422 when a post request can not be completed because of validation errors
Hint: Handling Errors in an API Application the Rails Way


Story 5: In order to increase efficiency, as a user of the API, I need to add an animal and a sighting at the same time.

Branch: submit-animal-with-sightings

Acceptance Criteria

Can create new animal along with sighting data in a single API request
Hint: Look into accepts_nested_attributes_for



TIPS: Error 500 in Postman, check to see if you have the appropriate "end" in the controller 