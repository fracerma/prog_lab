class LocationsController < ApplicationController
    def index
       @location = Location.all
    end

    def new 
        @newLoc = Location.new
    end

    def show
       redirect_to location_types_path(params[:id])
    end 


    def create
        if  Location.exists?(params[:id])
            render html: "Il locale che stai cercando di aggiungere gia' esiste"
            
        else 
            #Manca autenticazione admin
            @newLoc = Location.create(params.require(:locations).permit(:name, :lat, :long, :foto))
            redirect_to locations_path  
        end
    end

    #Manca autenticazione admin
    def edit 
        @update_loc = Location.find(params[:id])
    end 

    #Manca autenticazione admin
    def destroy 
        id = params[:id]
        @location = Location.find(id)
        @location.destroy
        redirect_to locations_path
    end

    def update
        @update_loc = Location.find(params[:id])
        @update_loc.update_attributes(name: params[:locations][:name], lat: params[:locations][:lat], long: params[:locations][:long], foto: params[:locations][:foto])
        redirect_to location_path(@update_loc)
    end
end
