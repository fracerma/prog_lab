class GatheringsController < ApplicationController

    before_action :is_logged


    # lista delle uscite dell'utente
    def index 
        @user = @current_user
        @gatherings = @user.gatherings
    end

    def create 
        @gathering=Gathering.new(date: params[:date])
        params[:partecipants].each do |part|
            @gathering.users << User.find(part)
        end  
        @gathering.location = Location.find(params[:location])
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
        @gathering=Gathering.find(params[:id])
        @gathering.update_attributes!(date: params[:date])
        @gathering.location = Location.find(params[:location])
		redirect_to gathering_path(@gathering)
    end

    # elimina l'uscita con quell'id
    def destroy 
        id = params[:id]
		@gathering = Gathering.find(id)
		@gathering.destroy
		redirect_to gatherings_path
    end 

#metodo che genera le location per un gathering da creare
    def generate_locations()
        @matching_loc = []
        index=0
        @partecipants = params[:partecipants]
        if(@partecipants)
            puts @partecipants[@partecipants.length] = @current_user.id
        else
            @partecipants = []
            puts @partecipants[0] = @current_user.id
        end
        @locations = Location.all
        if(@partecipants)
            @matching_loc = search_match(@partecipants)
            @date = params[:gathering][:date]
        else
            @matching_loc = @locations
            @date = params[:gathering][:date]
        end
    end 

    def update_location()
        @gathering = Gathering.find(params[:id])
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
        index=0
        @partecipants=[]
        @gathering.users.each do |part|
            puts @partecipants[index] = part.id
            index+=1
        end
        @locations = Location.all
        if(@partecipants)
            @matching_loc = search_match(@partecipants)
            @date =  params[:gathering][:date]
        else
            @matching_loc = @locations
            @date = params[:gathering][:date]
        end

    end

#metodo che dato un gruppo di utenti, seleziona tra i locali quelli che matchano con quegli utenti
    def search_match(partecipants)
        @locations = Location.all
        @partecipants = partecipants
        @matching_loc = []
        index = 0
        @locations.each do |loc|
            okay=0
            @partecipants.each do |part|
                part = User.find(part)
                if(! (loc.categories.include?(part.categories[0])) )
                    okay=0
                else 
                    okay+=1
                end
            end
            if(okay == @partecipants.length)
                puts @matching_loc[index]=loc
                index += 1
            end
        end
        return @matching_loc
    end


end
