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
 
 
 
Create a resource for animal with the following information: common name and scientific binomial
 
To generate resource:
 
  $rails generate resource Animal common_name:string scientific_binomial:string 
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
 
 
  $rails routes -E 
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
  $rails db:migrate 
 
   #delete the views folder 
 
Can see the data response of all the animals
   -Index is the requst to retrieve all instances created
 
   $ rails c 
   > Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
   >Animal.create common_name: 'Whale', scientific_binomial: 'Cetacea'
   > exit 
 
app/controller/animals_controller.rb 
//Index - To see all instances
``` ruby
 
   class AnimalsController < ApplicationController
 
   def index
       @animals = Animal.all
       render json:animals
   end
end
 
```
To check our index:  
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
 
Disable Authenticity Token:  
 
app/controllers/application_controller.rb
 
       class ApplicationController < ActionController::Base
           skip_before_action :verify_authenticity_token
       end
 
   
Can create a new animal in the database
 
- To create a new instance in the database
-create stong params/private and a create block  
 
app/controller/animals_controller.rb  
 
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
In postman:  
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
 
 
 
Can update an existing animal in the database  
- Update is to make changes to an already made istance
 
app/controller/animals_controller.rb  
 
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
In Postman:  
       HTTP verb: PATCH
       url: localhost:3000/animals/:id <--- this wil be the id # of specific instance
       choose "Body"
       choose "raw"
       choose "JSON"
 
Edit instance in Postman body with correction:  
 
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
 
 
 
Can remove an animal entry in the database  
-  The destroy action is the conventional Rails action for removing content from the database
 
app/controller/animals_controller.rb  
 
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
 
 
In Postman:  
       HTTP verb: DELETE
       url: localhost:3000/animals/:id <--- this wil be the id # of specific instance that is to be deleted
       choose "Body"
       choose "raw"
       choose "JSON"
 
In Postman Body: Should receive the item deleted  
 
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
 
 
// Animals.all //
 
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
       },
       {
           "id": 3,
           "common_name": "Penguin",
           "scientific_binomial": "Spheniscidae",
           "created_at": "2022-09-09T05:34:40.258Z",
           "updated_at": "2022-09-09T05:34:40.258Z"
       },
       {
           "id": 4,
           "common_name": "Jellyfish",
           "scientific_binomial": "Aurelia aurita",
           "created_at": "2022-09-09T05:42:44.400Z",
           "updated_at": "2022-09-09T05:45:02.291Z"
       }
   ]
 
 
 
Story 2: In order to track wildlife sightings, as a user of the API, I need to manage animal sightings.
 
$ git status
$ git add .
$ git commit -m "crud complete"
$ git status
$ git push origin animal-crud-actions
$ git checkout main
$ git checkout -d animal-crud-actions
$ git checkout -b sighting-crud-actions
 
 
Branch: sighting-crud-actions  
 
Acceptance Criteria
 
Create a resource for animal sightings with the following information: latitude, longitude, date
Hint: An animal has_many sightings (rails g resource Sighting animal_id:integer ...)
Hint: Date is written in Active Record as yyyy-mm-dd (“2022-07-28")
 
$ rails generate migration sighting_migrate 
 
     invoke  active_record
     create    db/migrate/20220909181304_sighting_migrate.rb
 
$ rails generate resource Sighting animal_id:integer latitude:string longitude:string date:date 
 
     invoke  active_record
     create    db/migrate/20220909181706_create_sightings.rb
     create    app/models/sighting.rb
     invoke    rspec
     create      spec/models/sighting_spec.rb
     invoke  controller
     create    app/controllers/sightings_controller.rb
     invoke    erb
     create      app/views/sightings
     invoke    rspec
     create      spec/requests/sightings_spec.rb
     invoke    helper
     create      app/helpers/sightings_helper.rb
     invoke      rspec
     create        spec/helpers/sightings_helper_spec.rb
     invoke  resource_route
      route    resources :sightings
   
 
 
 
$ rails routes -E SAVE THE ROUTES 
 
       --[ Route 1 ]------------------------------------------------------------------------------
       Prefix            | sightings
       Verb              | GET
       URI               | /sightings(.:format)
       Controller#Action | sightings#index
       --[ Route 2 ]------------------------------------------------------------------------------
       Prefix            |
       Verb              | POST
       URI               | /sightings(.:format)
       Controller#Action | sightings#create
       --[ Route 3 ]------------------------------------------------------------------------------
       Prefix            | new_sighting
       Verb              | GET
       URI               | /sightings/new(.:format)
       Controller#Action | sightings#new
       --[ Route 4 ]------------------------------------------------------------------------------
       Prefix            | edit_sighting
       Verb              | GET
       URI               | /sightings/:id/edit(.:format)
       Controller#Action | sightings#edit
       --[ Route 5 ]------------------------------------------------------------------------------
       Prefix            | sighting
       Verb              | GET
       URI               | /sightings/:id(.:format)
       Controller#Action | sightings#show
       --[ Route 6 ]------------------------------------------------------------------------------
       Prefix            |
       Verb              | PATCH
       URI               | /sightings/:id(.:format)
       Controller#Action | sightings#update
       --[ Route 7 ]------------------------------------------------------------------------------
       Prefix            |
       Verb              | PUT
       URI               | /sightings/:id(.:format)
       Controller#Action | sightings#update
       --[ Route 8 ]------------------------------------------------------------------------------
       Prefix            |
       Verb              | DELETE
       URI               | /sightings/:id(.:format)
       Controller#Action | sightings#destroy
       --[ Route 9 ]------------------------------------------------------------------------------
       Prefix            | animals
       Verb              | GET
       URI               | /animals(.:format)
       Controller#Action | animals#index
       --[ Route 10 ]-----------------------------------------------------------------------------
       Prefix            |
       Verb              | POST
       URI               | /animals(.:format)
       Controller#Action | animals#create
       --[ Route 11 ]-----------------------------------------------------------------------------
       Prefix            | new_animal
       Verb              | GET
       URI               | /animals/new(.:format)
       Controller#Action | animals#new
       --[ Route 12 ]-----------------------------------------------------------------------------
       Prefix            | edit_animal
       Verb              | GET
       URI               | /animals/:id/edit(.:format)
       Controller#Action | animals#edit
       --[ Route 13 ]-----------------------------------------------------------------------------
       Prefix            | animal
       Verb              | GET
       URI               | /animals/:id(.:format)
       Controller#Action | animals#show
       --[ Route 14 ]-----------------------------------------------------------------------------
       Prefix            |
       Verb              | PATCH
       URI               | /animals/:id(.:format)
       Controller#Action | animals#update
       --[ Route 15 ]-----------------------------------------------------------------------------
       Prefix            |
       Verb              | PUT
       URI               | /animals/:id(.:format)
       Controller#Action | animals#update
       --[ Route 16 ]-----------------------------------------------------------------------------
       Prefix            |
       Verb              | DELETE
       URI               | /animals/:id(.:format)
       Controller#Action | animals#destroy
       --[ Route 17 ]-----------------------------------------------------------------------------
 
 
 
 
$ rails db:migrate 
#delete the views folder 
 
 
Can create a new animal sighting in the database  
 
app/controller/sighting_controller.rb
 
//Index - To see all instances
 
``` Ruby
def index
   @sightings = Sighting.all
   render json: sightings
   end
def show
   sighting = Sighting.find(params[:id])
   render json: sighting
   end
def create
   sighting = Sighting.create(sighting_params)
   if sighting.valid?
       render json: sighting
       else
           render json: animal.errors
       end
   end
private
def sighting_params
   params.require(:sighting).permit(:animal_id, :latitude, :longitude, :date)
   end
 
 ``` 
 
 
In Postman:
       HTTP verb: POST
       url: localhost:3000/sightings
       choose "Body"
       choose "raw"
       choose "JSON"
 
 
        {
       "animal_id":1,
       "latitude": "32.7157° N"
       "longitude": "117.1611° W"
       "date": 20220909
 
       }
 
//output:
 
{
   "id": 1,
   "animal_id": 1,
   "latitude": "32.7157° N",
   "longitude": "117.1611° W",
   "date": 20220909,
   "created_at": "2022-09-09T18:38:56.111Z",
   "updated_at": "2022-09-09T18:38:56.111Z"
}
 
 
        {
       "animal_id":2,
       "latitude": "8.7832° S",
       "longitude": "34.5085° E",
       "date": 20220908
 
       }
 
//output:
 
{
   "id": 2,
   "animal_id": 2,
   "latitude": "8.7832° S",
   "longitude": "34.5085° E",
   "date": 20220908,
   "created_at": "2022-09-09T18:40:16.435Z",
   "updated_at": "2022-09-09T18:40:16.435Z"
}
 
       {
       "animal_id":3,
       "latitude": "82.8628° S",
       "longitude": "135.0000° E",
       "date": 20220907
 
       }
 
//output:
 
{
   "id": 3,
   "animal_id": 3,
   "latitude": "82.8628° S",
   "longitude": "135.0000° E",
   "date": 20220907,
   "created_at": "2022-09-09T18:40:40.053Z",
   "updated_at": "2022-09-09T18:40:40.053Z"
}
 
       {
       "animal_id":4,
       "latitude": "19.8968° N",
       "longitude": "155.5828° W", "date": 20220908
 
       }
 
//output:
 
{
   "id": 4,
   "animal_id": 4,
   "latitude": "19.8968° N",
   "longitude": "155.5828° W",
   "date": 20220908,
   "created_at": "2022-09-09T18:41:15.691Z",
   "updated_at": "2022-09-09T18:41:15.691Z"
}
 
 
Can update an existing animal sighting in the database
 
app/controller/sighting_controller.rb
 
```Ruby
 
def index
   @sightings = Sighting.all
   render json: sightings
   end
def show
   sighting = Sighting.find(params[:id])
   render json: sighting
   end
def create
   sighting = Sighting.create(sighting_params)
   if sighting.valid?
       render json: sighting
       else
           render json: animal.errors
       end
   end
   def update
   sighting = Sighting.find(params[:id])
   sighting.update(sighting_params)
       if sighting.valid?
           render json: sighting
           else
               render json:sighting.errors
               end
   end
private
def sighting_params
   params.require(:sighting).permit(:animal_id, :latitude, :longitude, :date)
   end
```
 
In Postman: 
       HTTP verb: PATCH
       url: localhost:3000/sightings/:id <--- this wil be the id # of specific instance
       choose "Body"
       choose "raw"
       choose "JSON"
 
Edit instance in Postman body with correction:
//change was to the date from 20220908 > 20220901
 
       {
           "id": 4,
           "animal_id": 4,
           "latitude": "19.8968° N",
           "longitude": "155.5828° W",
           "date": 20220901
      
       }
 
//output:
 
{
   "animal_id": 4,
   "latitude": "19.8968° N",
   "longitude": "155.5828° W",
   "date": 20220901,
   "id": 4,
   "created_at": "2022-09-09T18:41:15.691Z",
   "updated_at": "2022-09-09T18:55:24.283Z"
}
 
 
 
Can remove an animal sighting in the database
 
app/controller/sighting_controller.rb
 
```Ruby
 
def index
       @sightings = Sighting.all
       render json: @sightings
       end
   def show
       sighting = Sighting.find(params[:id])
       render json: sighting
       end
   def create
       sighting = Sighting.create(sighting_params)
       if sighting.valid?
           render json: sighting
           else
               render json: animal.errors
           end
       end
       def update
           sighting = Sighting.find(params[:id])
           sighting.update(sighting_params)
               if sighting.valid?
                   render json: sighting
                   else
                       render json:sighting.errors
                       end
           end
       def destroy
        sighting = Sighting.find(param[:id])
           if sighting.destroy
               render json: sighting
               else
                   render json: sighting.errors
                   end
       end
   private
   def sighting_params
       params.require(:sighting).permit(:animal_id, :latitude, :longitude, :date)
       end
 
```
In Postman: 
       HTTP verb: DELETE
       url: localhost:3000/sightings/:id <--- this wil be the id # of specific instance that is to be deleted
       choose "Body"
       choose "raw"
       choose "JSON"
 
In Postman Body: Should receive the item deleted
 
ex)
 
DELETE localhost:3000/sighting/4
 
//output: To be the instance you have deleted
 
{
   "id": 4,
   "animal_id": 4,
   "latitude": "19.8968° N",
   "longitude": "155.5828° W",
   "date": "2022-09-01",
   "created_at": "2022-09-09T18:41:15.691Z",
   "updated_at": "2022-09-09T18:55:24.283Z"
}
 
 
$ git status
$ git add .
$ git commit -m "crud complete"
$ git status
$ git push origin sighting-crud-actions
$ git checkout main
$ git checkout -b animal-sightings-reports
 
 
Story 3: In order to see the wildlife sightings, as a user of the API, I need to run reports on animal sightings.
 
Branch: animal-sightings-reports
 
Acceptance Criteria
 
Can see one animal with all its associated sightings
Hint: Checkout this example on how to include associated records:(referring to example: https://github.com/learn-co-students/js-rails-as-api-rendering-related-object-data-in-json-v-000#using-include)


app/model/animal.rb

//To associate Sighting table to Animal, we use keyword has_many and pass the table name as plural 

class Animal < ApplicationRecord
    has_many:sightings
end

app/model/sighting.rb

//To associate Sighting as  belonging to the model Animal, use keyword belongs_to, and pass the table name as singular 

class Sighting < ApplicationRecord
    belongs_to:animal
end

app/controller/sightings_controller 

 update index method by using include: to add the animals model 

 update show method by using include: to add the animals model and add conditional statements:     
    1. if sighting, include animals table info 
    2. else render error message 


```Ruby
 
def index
        @sightings = Sighting.all
        render json: sightings,include:[:animals]
        end
    def show
        sighting = Sighting.find(id: params[:id])
        if sighting 
        render json: sighting,include:[:animals]
        else 
        render json: {message: 'No sighting found with that id'}
        end
        end
    def create
        sighting = Sighting.create(sighting_params)
        if sighting.valid?
            render json: sighting
            else
                render json: animal.errors
            end
        end
        def update
            sighting = Sighting.find(params[:id])
            sighting.update(sighting_params)
                if sighting.valid?
                    render json: sighting
                    else
                        render json:sighting.errors
                        end
            end
        def destroy
         sighting = Sighting.find(param[:id])
            if sighting.destroy
                render json: sighting
                else
                    render json: sighting.errors
                    end
        end
    private
    def sighting_params
        params.require(:sighting).permit(:animal_id, :latitude, :longitude, :date)
        end
    end
end

```


app/controller/animals_controller.rb

 update show method by using include: to add the sightings model 

``` ruby 

def index
        animals = Animal.all 
        render json: animals 
    end
    def show
        animal = Animal.find(params[:id])
        render json: animal, include:[:sightings]
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
 
In Postman: 
       HTTP verb: GET
       url: localhost:3000/animals/:id <--- this will be the id # of specific instance of animal, which should also show their associationed sighting 
       choose "Body"
       choose "raw"
       choose "JSON"

GET localhost:3000/animal/1

//output: 

        {
            "id": 1,
            "common_name": "Dog",
            "scientific_binomial": "Canis familiaris",
            "created_at": "2022-09-09T04:45:15.831Z",
            "updated_at": "2022-09-09T04:45:15.831Z",
            "sightings": [
                {
                    "id": 1,
                    "animal_id": 1,
                    "latitude": "32.7157° N",
                    "longitude": "117.1611° W",
                    "date": "2022-09-09",
                    "created_at": "2022-09-09T18:38:56.111Z",
                    "updated_at": "2022-09-09T18:38:56.111Z"
                }
            ]
        }



 
Can see all the all sightings during a given time period
Hint: Your controller can use a range to look like this:
 
class SightingsController < ApplicationController
 def index
   sightings = Sighting.where(date: params[:start_date]..params[:end_date])
   render json: sightings
 end
end

Hint: Be sure to add the start_date and end_date to what is permitted in your strong parameters method

``` Ruby 

 def index
        sightings = Sighting.where(date: params[:start_date]..params[:end_date])
            render json: sightings
        end
        def show
            sighting = Sighting.find(id: params[:id])
            if sighting 
            render json: sighting,include:[:animals]
                else 
                render json: {message: 'No sighting found with that id'}
            end
        end
    def create
        sighting = Sighting.create(sighting_params)
        if sighting.valid?
            render json: sighting
            else
                render json: animal.errors
            end
        end
        def update
            sighting = Sighting.find(params[:id])
            sighting.update(sighting_params)
                if sighting.valid?
                    render json: sighting
                    else
                        render json:sighting.errors
                        end
            end
        def destroy
         sighting = Sighting.find(param[:id])
            if sighting.destroy
                render json: sighting
                else
                    render json: sighting.errors
                    end
        end
    private
    def sighting_params
        params.require(:sighting).permit(:animal_id, :latitude, :longitude, :start_date, :end_date)
        end
end

```
 
 
Hint: Utilize the params section in Postman to ease the developer experience 
Hint: Routes with params
 
 In Postman: 
       HTTP verb: GET 
       url: localhost:3000/sightings 
    In Params: 
       KEY: start_date VALUE: 20220901 
       KEY: end_date VALUE: 20220909

//output: 

        [
            {
                "id": 1,
                "animal_id": 1,
                "latitude": "32.7157° N",
                "longitude": "117.1611° W",
                "date": "2022-09-09",
                "created_at": "2022-09-09T18:38:56.111Z",
                "updated_at": "2022-09-09T18:38:56.111Z"
            },
            {
                "id": 2,
                "animal_id": 2,
                "latitude": "8.7832° S",
                "longitude": "34.5085° E",
                "date": "2022-09-08",
                "created_at": "2022-09-09T18:40:16.435Z",
                "updated_at": "2022-09-09T18:40:16.435Z"
            },
            {
                "id": 3,
                "animal_id": 3,
                "latitude": "82.8628° S",
                "longitude": "135.0000° E",
                "date": "2022-09-07",
                "created_at": "2022-09-09T18:40:40.053Z",
                "updated_at": "2022-09-09T18:40:40.053Z"
            }
        ]
 

$ git status
$ git add 
$ git push origin<branch-name>
- merge into main on github
$ git checkout main
$ git pull origin 
$ git checkout -b animal-sightings-specs


Stretch Challenges

Story 4: In order to see the wildlife sightings contain valid data, as a user of the API, I need to include proper specs.
 
Branch: animal-sightings-specs
 
Acceptance Criteria

Validations will require specs in spec/models and the controller methods will require specs in spec/requests.

Sighting model and requests spec have already been created 
To create a rspec Animal model and requests, run the following command:

$ rails generate rspec:model Animal
    create  spec/models/animal_spec.rb

$ rails generate rspec:controller Animals
    create  spec/requests/animals_spec.rb
 
Can see validation errors if an animal doesn't include a common name and scientific binomial

    spec/models animal_spec.rb

    ```ruby 
   require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'Animal Model' do 
  it 'throws an error if common name is empty' do 
  animal = Animal.create common_name: nil, scientific_binomial: 'jellyfish absolute'

  p animal.errors[:common_name]

    expect(animal.errors[:common_name]).to_not be_empty
    expect(animal.errors[:common_name]).to eq ["can't be blank"]
  end
  it 'throws an error if scientific_binomial is empty' do 
    animal = Animal.create common_name: 'jellyfish', scientific_binomial: nil
  
    p animal.errors[:scientific_binomial]
  
      expect(animal.errors[:scientific_binomial]).to_not be_empty
      expect(animal.errors[:scientific_binomial]).to eq ["can't be blank"]
  end
end
end
    ```


app/models/animal.rb 

```ruby 

class Animal < ApplicationRecord
    validates :common_name, :scientific_binomial,  presence: true
    has_many:sightings
end

```

Can see validation errors if a sighting doesn't include latitude, longitude, or a date

spec/models/sighting_spec.rb

```ruby 

require 'rails_helper'

RSpec.describe Sighting, type: :model do
  describe 'Sighting Model' do 
    it 'throws an error if latitude is empty' do 
    sighting = Sighting.create animal_id: 1, latitude:nil, longitude: '89274.123 N', date:20220901 
  
    p sighting.errors[:latitude]
  
      expect(sighting.errors[:latitude]).to_not be_empty
      expect(sighting.errors[:latitude]).to eq ["can't be blank"]
    end
    it 'throws an error if longitude is empty' do 
      sighting = Sighting.create animal_id: 1, latitude: '1234.123 S', longitude:nil, date:20220901 
    
      p sighting.errors[:longitude]
    
        expect(sighting.errors[:longitude]).to_not be_empty
        expect(sighting.errors[:longitude]).to eq ["can't be blank"]
    end
    it 'throws an error if date is empty' do 
      sighting = Sighting.create animal_id: 1, latitude: '1234.123 S', longitude:'89274.123 N', date:nil 
    
      p sighting.errors[:date]
    
        expect(sighting.errors[:date]).to_not be_empty
        expect(sighting.errors[:date]).to eq ["can't be blank"]
    end
  end
end

```

app/models/sighting.rb

```ruby

class Sighting < ApplicationRecord
    validates :latitude, :longitude, :date, presence: true
    belongs_to:animal
end

```

To run test: 
$ rspec spec/models/sighting_spec.rb

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


