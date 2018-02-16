class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user,   only: [:index, :edit, :update, :show]

  def logged_in_user
    unless logged_in?
      flash.notice = "Please Log In"
      redirect_to root_path
    end
  end

  # Confirms the correct user or the admin user.
  def correct_user
    # When an admin tries to check all the users
    if params[:id] == nil
      unless current_user.admin
        flash.notice = "You are not the right user !"
        redirect_to root_path
      end
    else
      @user = User.find(params[:id])
      # When the user is not the administrator
      unless current_user.admin
        unless @user == current_user
          flash.notice = "Your are not the right user !"
          redirect_to root_path
        end
      end
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :first_name, :last_name, :admin, :password, :password_confirmation)
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      #when the admin create a user, the user will be activated automatically
      if current_user != nil && current_user.admin
        @user.activated = true
        @user.save
        redirect_to @user
      else
        flash.notice = "Thanks for signing up"
        redirect_to root_path
      end
    else
        render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path(:user =>params[:admin])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end


end
