class LocationsController < ApplicationController
    def index
       @location = Location.all
    end

    def show
        if Location.exists?(params[:id])
            @location = Location.find(params[:id])
            @catId = Type.find(params[:id])
            @catId.each do |c|
                @cats += Category.find(c)
            end
        else 
            render html: "Locale non trovato"
        end
    end 

    def show_cats
        if Location.exists?(params[:id])
            @cats = Type.find(params[:id])
            render html: @cats.name
        else 
            render html: "Locale non trovato"
        end
    end 

    def create
        if  Location.exists?(params[:id])
            @location = Location.find(params[:id])
            render html: "Il locale che stai cercando di aggiungere gia' esiste"
            
        else 
            #Manca autenticazione admin
            @newLoc = Location.create!(params[:movie].permit(:name, :lat, :long))
            redirect_to locations_path  
        end
    end

    #Manca autenticazione admin
    def edit 
    end 

    #Manca autenticazione admin
    def destroy 
        id = params[:id]
        @location = Location.find(id)
        @location.destroy
        redirect_to locations_path
    end

    def update
    end
end
