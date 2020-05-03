class UsersController < ApplicationController
    before_action :is_logged, except: [:new, :create]
    def show
    end

    def new
        @user=User.new
    end

    def create
        user=User.create!(params.require(:user).permit(:name,:email,:password))
        if(user.valid?)
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

    private

    def is_logged
        if(!@current_user)
            redirect_to login_path
        end

    end
end
