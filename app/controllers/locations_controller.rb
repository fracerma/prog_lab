class LocationsController < ApplicationController
    before_action :is_logged
    skip_before_action :verify_authenticity_token

    def index
       @location = Location.all
    end

    def new 
        @newLoc = Location.new
        @categories = Category.all
    end

    def show
        @location = Location.find(params[:id])
        @cats = []
        @location.categories.each do |c|
            @cats.append(Category.find(c.id))
        end

    end 

    #Manca autenticazione admin
    def create
        if  Location.exists?(params[:id])
            render html: "Il locale che stai cercando di aggiungere gia' esiste"
            
        else 
            #Controlla che  il locale inserito non esista gia'DA FARE
            @newLoc = Location.create!(params.require(:locations).permit(:name, :lat, :long, :foto))
            @array = params[:categ]
            @arr = []
            @array.each do |c|
                @arr.append(Category.find(c))
            end
            
            @newLoc.categories = @arr
            
            redirect_to locations_path  
        end
    end

    #Manca autenticazione admin
    #Devi passare un array che contiene l-id di location e l-id di category 
    #cosi lo cerchi dentro type e se non esiste la categoria indicata dentro type,  vuol dire 
    #che il locale indicato non gli appartiene e quindi aggiungi la tupla. 
    def edit 
        @update_loc = Location.find(params[:id])
        @catId = Type.find(params[:id])
    end 

    #Manca autenticazione admin
    def destroy 
        id = params[:id]
        @location = Location.find(id)
        @location.destroy
        redirect_to locations_path
    end

    #Manca autenticazione admin
    def update
        #@update_loc = Location.find(params[:id])
        @update_loc.update_attributes(name: params[:locations][:name], lat: params[:locations][:lat], long: params[:locations][:long], foto: params[:locations][:foto])
        redirect_to location_path(@update_loc)
    end
end
