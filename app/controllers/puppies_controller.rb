class PuppiesController < ApplicationController
    def index
       
    end

    def show
        if !session['logged_in?'] == true
            redirect_to("/login")
        end
        @puppy = Puppy.find(session[:user_id])
    end

    def friends
        @puppy = Puppy.find(session[:user_id])
        @friends = @puppy.friends
    end

    def unfriend

        matchup = Friendship.find_by({puppy_id: params[:id], friend_id: params[:friend_id]})
        Friendship.destroy(matchup.id)
        redirect_to("#{puppy_path}/friends")
    end

    def edit_profile
    user = Puppy.find(params[:id])
        if params[:password]
            new_password = BCrypt::Password.create(params[:password])
            user.update({password_digest: new_password })
            redirect_to '/login'
        end
    end



end