class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    def show
    end

    def new
        @user=User.new
    end

    def create
        user=User.new(params.require(:user).permit(:name,:email,:password))
        user.admin=false
        if(user.valid?)
            user.save
            flash[:notice] = "Registered!"
            redirect_to root_path
        else
            flash[:allert] = "Password or email invalid!"
            redirect_to root_path
        end
    end

    def edit
        
    end

    def update
        if(@current_user.update(params.require(:user).permit(:name,:email,:avatar)))
            redirect_to user_path
        else
            flash[:alert]="Email is used!"
            redirect_to edit_user_path
        end

    end
    
    def destroy
        User.delete(@current_user)
        session[:user_id] = nil
        redirect_to root_path
    end


end
