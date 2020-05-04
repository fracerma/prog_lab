class CategoriesController < ApplicationController
    # lista di tutte le categorie
    def index # /categories
        @categories = Category.all
    end

    def create # /categories
        @category = Category.create(params.require(:categories).permit(:name))
        redirect_to categories_path
    end 

    def new  # /categories/new
        @category = Category.new
    end 

    # con la show voglio mostrare la lista di tutti i locali che hanno come proprietà quella categoria
    def show  # /categories/:id
        #render html: 'in corso'
        # -> non esiste uesto percorso, da creare: redirect_to type_categories_path(params[:id])

    end

    # modifica (da parte di chi?) una categoria id
    def edit  # /categories/:id/edit
        @category = Category.find(params[:id])
    end

    # questo metodo viene chiamato dopo il metodo #edit:
    # quando qualcuno modifica una categoria e vuole aggiornare le modifiche nel database 
    def update  # /categories/:id
        id = params[:id]
        @category = Category.find(id)
        @category.update_attributes!(params[:category].permit(:name))
		redirect_to categories_path
    end

    # elimina la categoria id
    def destroy  # /categories/:id
        id = params[:id]
		@category = Category.find(id)
		@category.destroy
		redirect_to categories_path
    end 

end
