class GatheringsController < ApplicationController

    before_action :is_logged


    # lista delle uscite dell'utente
    def index 
        @user = @current_user
        @gatherings = @user.gatherings
    end

    def create 
        @gathering=Gathering.new(params.require(:gathering).permit(:date))
        @gathering.users << @current_user
        @gathering.location = Location.find(1)
        params[:partecipants].each do |partecipant|
            @gathering.users << User.find(partecipant)
        end
        @gathering.save
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
        if(params[:adduser])
            params[:adduser].each do |user|
                @gathering.users << User.find(user)
            end
        end
        if(params[:deleteuser])
            params[:deleteuser].each do |user|
                @gathering.users.delete(User.find(user))
            end
        end
        @gathering.update_attributes!(params[:gathering].permit(:date))
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
