class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def leaders
        @users = User.order(score: :desc)
    end

    def create
        @user = User.new(user_params)
        @user.score = 0
        if @user.save
            session[:user_id] = @user.id
            redirect_to('/puzzles')
        else
            flash[:error] = @user.errors.full_messages.to_sentence
            redirect_to('/signup')
        end
    end

    def show
        @user = current_user
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
