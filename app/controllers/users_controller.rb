class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    def show
    end

    def edit
    end

    def update
        if(@current_user.update(params.require(:user).permit(:name,:email,:avatar)))
            redirect_to root_path
        else
            flash[:alert]="Email is used!"
            redirect_to edit_user_path
        end

    end

    def index_friends
        @friends=current_user.friends
    end

    def index_users
        @users= User.where.not(id: current_user.friends) #TODO fai vedere solo quelli con ruolo user
    end
    
    def add_friend
        new_friend=User.find(params[:id])
        if(!current_user.friends.include? new_friend)
            current_user.friends<<new_friend
            new_friend.friends<<current_user
            redirect_to user_friends_path
        else
            redirect_to user_all_path
        end
    end

    def remove_friend
        rem_friend=User.find(params[:id])
        if(current_user.friends.include? rem_friend)
            current_user.friends.delete(rem_friend)
        end
        redirect_to user_friends_path
    end

    def destroy
        current_user.destroy
        redirect_to root_path
    end

    

end
