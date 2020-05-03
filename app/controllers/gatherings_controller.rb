class GatheringsController < ApplicationController

    before_action :is_logged


    # lista delle uscite dell'utente
    def index 
        @user = @current_user
        @gatherings = @user.gatherings
    end

    def create 
        #TODO aggiungi elementi al database
        #@gathering=Gathering.create!(params.require(:gathering).permit(:date,:users,:location))
        redirect_to gatherings_path
    end 

    def new
        @gathering = Gathering.new
    end 

    # voglio mostare le info di una singola uscita
    def show  
        @gathering= Gathering.find(params[:id])
    end

    # modifica le informazioni di un'uscita
    def edit 
        @gathering = Gathering.find(params[:id])
    end

    def update  
        id = params[:id]
        @gathering = Gathering.find(id)
        #TODO aggiorna database con le modifiche
        #@gathering.update_attributes!(params[:gathering].permit(:date,:users,:location))
		redirect_to gathering_path(@gathering)
    end

    # elimina l'uscita con quell'id
    def destroy 
        id = params[:id]
		@gathering = Gathering.find(id)
		@gathering.destroy
		redirect_to gatherings_path
    end 


    def generate_locations
        
    end


end
