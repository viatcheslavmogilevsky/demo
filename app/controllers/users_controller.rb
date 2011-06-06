class UsersController < ApplicationController

 
  def new
    @user = User.new
    @title = "Sign up"
  end
  

  def show
   @user = User.find(params[:id])
   @title = @user.name
  end
 

  def create
   @user = User.new(params[:user])
   if @user.save
     sign_in @user
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user
   else
    @user.name = ""
    @user.email = ""
    @user.password = ""
    @user.password_confirmation = ""
    @title = "Sign up"
    render 'new' 
   end
  end

  def edit 
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def index
    @title = "All users"
    @users = User.all
  end


  
end
