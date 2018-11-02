class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def sign_in
    if params[:commit] == 'Sign Up' && !create
      flash[:alert] = "Something went wrong. New user couldn't be created => #{@user.errors.full_messages}"
      redirect_to registration_new_path
    else
      log_in ? (redirect_to gossips_path) : (redirect_to registration_new_path)
    end
  end

  def log_in
    @user = User.find_by(email: params[:user][:email])
    if @user.password == params[:user][:password]
      User.all.each { |user| user.update(is_logged: user.id == @user.id) }
      flash[:success] = "You're now logged as #{@user.name}"
      true
    else
      flash[:alert] = "Log in failed, password and email don't match."
      false
    end
  end

  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
    @user.save
  end

  def log_out
    User.find_by(is_logged: true).update(is_logged: false)
    redirect_to root_path, :notice => "Logged out!"
  end
end
