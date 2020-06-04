class LocationsController < ApplicationController
    before_action :is_logged
    

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
        if  !Location.where(name: params[:locations][:name]).empty?
            render html: "Il locale che stai cercango di aggiungere gia' esiste"
            
        else 
            @client = OpenStreetMap::Client.new
            @loc = "#{params[:locations][:street]}/" << "/#{params[:locations][:city]}"
            @res=@client.search(q: @loc, format: 'json', addressdetails: '1', accept_language: 'it')
            @lat=@res[0]['lat']
            @long=@res[0]['lon']
        
            @newLoc = Location.new(params.require(:locations).permit(:name, :foto))
            @newLoc.lat=@lat
            @newLoc.long=@long
            @newLoc.street="#{params[:locations][:street]}, " << "#{params[:locations][:city]}"
           
            #@newLoc.update_attributes(status: "pending")
            @array = params[:categ]
            @arr = []
            @array.each do |c|
                @arr.append(Category.find(c))
            end
            
            @newLoc.categories = @arr
            @newLoc.save
            
            redirect_to locations_path  
         end
    end

    #Manca autenticazione admin
    #Devi passare un array che contiene l-id di location e l-id di category 
    #cosi lo cerchi dentro type e se non esiste la categoria indicata dentro type,  vuol dire 
    #che il locale indicato non gli appartiene e quindi aggiungi la tupla. 
    def edit 
        @update_loc = Location.find(params[:id])
        @cats = @update_loc.categories
        @categories = Category.all
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
        @update_loc = Location.find(params[:id])
        @update_loc.update_attributes(name: params[:locations][:name], lat: params[:locations][:lat], long: params[:locations][:long], foto: params[:locations][:foto])
        @allCats = params[:categ]
        @tmp = []
        @allCats.each do |c|
                @tmp.append(Category.find(c))
            end
            
        @update_loc.categories = @tmp
        redirect_to location_path(@update_loc)
    end
end
