class LocationsController < ApplicationController
    before_action :authenticate_user!

    def index_admin
        if current_user.is_admin?
            @locat = Location.all
        else 
            redirect_to locations_path
        end
    end

    def index
        if current_user.is_owner?
            @locations
        else
            @location = Location.where(status: "accepted")
        end
    end

    def new 
        @newLoc = Location.new
        @categories = Category.all
        @noCats = "Non ci sono categorie disponibili"
    end

    def show
        if @current_user.admin
            logger.debug "qui"  
            @location = Location.where(id: params[:id])[0]
            logger.debug @location
        else 
            @location = Location.where(status: "accepted", id: params[:id])[0]
        end
        
        @cats = []
        if @location != nil
            @location.categories.each do |c|
                @cats.append(Category.find(c.id))
            end
        end
    end 

    def create
        if  !Location.where(name: params[:locations][:name], name: params[:locations][:lat], name: params[:locations][:long] ).empty?
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
           
            @newLoc.update_attributes(status: "pending")
            @array = params[:categ]
            if @array != nil
                @arr = []
                @array.each do |c|
                    @arr.append(Category.find(c))
                end
                @newLoc.categories = @arr
            end
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
        if $admin == true
            redirect_to index_admin_path
        else 
            redirect_to locations_path
        end
    end

    #Manca autenticazione admin
    def update
        @update_loc = Location.where(id: params[:id]).first
        @update_loc.update_attributes(name: params[:locations][:name], lat: params[:locations][:lat], long: params[:locations][:long], foto: params[:locations][:foto])
        @allCats = params[:categ]
        @tmp = []
        @allCats.each do |c|
            @tmp.append(Category.find(c))
        end
            
        @update_loc.categories = @tmp
        @update_loc.update_attributes(status: "pending")
        redirect_to location_path(@update_loc)
    end

    def accept
        @list = Location.where(status: "pending")
        @noList = "Non ci sono locali da accettare"
    end

    def accept_locations
        @list = Location.where(status: "pending")
        @accept = params[:accepted]
        if @list != nil 
            @list.each do |nl|
                @n = Location.find(nl.id)
                @n.update_attributes(status: "rejected")
                
            end
            if @accept != nil 
                @accept.each do |al|
                    @a = Location.find(al)
                    @a.update_attributes(status: "accepted")
                end
            end
            
        end
        redirect_to index_admin_path
    end

    def addto_favloc
        id = params[:id]
        @loc = Location.find(id)
        if(!current_user.locations.include?(@loc))
            current_user.locations << @loc
        end
        redirect_to locations_path
    end

    def deletefrom_favloc
        id = params[:id]
        @loc=Location.find(id)
        if(current_user.locations.include?(@loc))
            current_user.locations.delete(@loc)
        end
        redirect_to locations_path
    end

    def index_favloc
        @locations=@current_user.locations
    end

end
