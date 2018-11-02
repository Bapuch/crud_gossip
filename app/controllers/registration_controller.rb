class RegistrationController < ApplicationController
  attr_accessor :log_user

  def new
    @user = User.new
  end

  def log_in
    create if params[:commit] == 'Sign Up'
    @user = User.find_by(email: params[:user][:email])
    if @user.password == params[:user][:password]
      User.all.each { |user| user.update(is_logged: user.id == @user.id) }
      redirect_to gossips_path
    else
      render :new, alert: "Something went wrong. New user couldn't be created"
    end
  end

  def create
    @gossip = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
    @user = User.new
    if @gossip.save
      flash[:success] = "User has been successfully created"
    else
      flash[:alert] = "Something went wrong. New user couldn't be created"
    end
  end

  def log_out
    User.find_by(is_logged: true).update(is_logged: false)
    redirect_to root_path, :notice => "Logged out!"
  end
end
