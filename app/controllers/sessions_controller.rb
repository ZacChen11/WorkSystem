class SessionsController < ApplicationController
  skip_before_action :verify_user_logged_in_before_action, only: [:create, :new]
  before_action :verify_user_already_logged_in_before_action, only: [:create, :new]

  def create
    # check if user uses use name or email to login in
    if validate_email_format(params[:email_or_username])
      user = User.find_by(email: params[:email_or_username].downcase)
    else
      user = User.where('lower(user_name) = ?', params[:email_or_username].downcase.delete(' ')).first
    end
    if user && user.authenticate(params[:password])
      if user.activated
        log_in(user)
         return redirect_to user_profile_path
      else
        flash.notice = "The User Account is not activated !!"
        return redirect_to login_path
      end
    end

    flash.now.notice = "Incorrect email address or password !!"
    return render 'new'

  end

  def destroy
    log_out
    redirect_to login_path
  end

  def new
  end


  private
  def validate_email_format(email)
    email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email =~ email_format
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end


end
