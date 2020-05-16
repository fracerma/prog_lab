class LocationsController < ApplicationController
    before_action :is_logged
    
    $admin = true

    def index_admin
        if $admin == true
            @locat = Location.all
        else 
            redirect_to locations_path
        end
    end

    def index
        @location = Location.where(status: "accepted")
    end

    def new 
        @newLoc = Location.new
        @categories = Category.all
        @noCats = "Non ci sono categorie disponibili"
    end

    def show
        if $admin  
            @location = Location.find(params[:id])
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

    #Manca autenticazione admin
    def create
        if  !Location.where(name: params[:locations][:name], name: params[:locations][:lat], name: params[:locations][:long] ).empty?
            render html: "Il locale che stai cercango di aggiungere gia' esiste"
            
        else 
            #Controlla che  il locale inserito non esista gia'DA FARE
            @newLoc = Location.create!(params.require(:locations).permit(:name, :lat, :long, :foto))
            @newLoc.update_attributes(status: "pending")
            @array = params[:categ]
            if @array != nil
                @arr = []
                @array.each do |c|
                    @arr.append(Category.find(c))
                end
                @newLoc.categories = @arr
            end
            
            redirect_to locations_path  
        end
    end

    #Manca autenticazione admin
    #Devi passare un array che contiene l-id di location e l-id di category 
    #cosi lo cerchi dentro type e se non esiste la categoria indicata dentro type,  vuol dire 
    #che il locale indicato non gli appartiene e quindi aggiungi la tupla. 
    def edit 
        if !$admin 
            redirect_to locations_path
        else 
            @update_loc = Location.find(params[:id])
            @cats = @update_loc.categories
            @categories = Category.all
            @status_array = ["accepted", "pending", "rejected"]
        end
    end 

    #Manca autenticazione admin
    def destroy
        if !$admin 
            redirect_to locations_path
        else 
            id = params[:id]
            @location = Location.find(id)      
            @location.destroy
            if $admin == true
                redirect_to index_admin_path
            else 
                redirect_to locations_path
            end
        end
    end

    #Manca autenticazione admin
    def update
        @update_loc = Location.where(id: params[:id]).first
        @update_loc.update_attributes(name: params[:locations][:name], lat: params[:locations][:lat], long: params[:locations][:long], foto: params[:locations][:foto], status: params[:status])
        @allCats = params[:categ]
        @tmp = []
        @allCats.each do |c|
            @tmp.append(Category.find(c))
        end
            
        @update_loc.categories = @tmp
        redirect_to location_path(@update_loc)
    end

    def accept
        if !$admin 
            redirect_to locations_path
        end
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
end
