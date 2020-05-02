class CategoriesController < ApplicationController
    # lista di tutte le categorie
    def index # /categories
        @categories = Category.all
    end

    def create # /categories
        Category.create!(params[:category].permit(:name))
        redirect_to categories_path
    end 

    def new  # /categories/new
        @category = Category.new
    end 

    # modifica (da parte di chi?) una categoria id
    def edit  # /categories/:id/edit
        id = params[:id]
        @category = Category.find(id)
    end
    
    # mostra una certa categoria id 
    def show  # /categories/:id
        id = params[:id]
        if Category.exists?(id)
            @category = Category.find(id)
        else
            render html: 'Movie does not exit'
        end
    end

    # questo metodo viene chiamato dopo il metodo #edit:
    # quando qualcuno modifica una categoria e vuole 
    # aggiornare le modifiche nel database 
    def update  # /categories/:id
        id = params[:id]
        @category = Category.find(id)
        @category.update_attributes!(params[:category].permit(:name))
		redirect_to category_path(@category)
    end

    # elimina la categoria id
    def destroy  # /categories/:id
        id = params[:id]
		@category = Category.find(id)
		@category.destroy
		redirect_to categories_path
    end 

end
