class SightingsController < ApplicationController
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
