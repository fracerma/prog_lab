class TypesController < ApplicationController
    #http://localhost:3000/locations/:id/types
    def index
        if Type.exists?(params[:location_id])
            @location = Location.find(params[:location_id])
            @catId = Type.where(location_id: @location.id ).pluck(:category_id)
            @cats = []
            @catId.each do |c|
                @cats.append(Category.where(id: c).pluck(:name))
            end
            respond_to do |format|
                format.html
                format.json { render :json => @cats}
                format.html { render :html => @cats}
            end
            
        else 
            render html: "Locale non trovato"
        end
       
     end
 
     def show
         
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
         
     end
 
     #Manca autenticazione admin
     def edit 
     end 
 
     #Manca autenticazione admin
     def destroy 
     end
 
     def update
     end
end
