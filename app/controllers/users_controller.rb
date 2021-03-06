class UsersController < ApplicationController
before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
before_filter :correct_user, :only => [:edit, :update]
before_filter :admin_user,   :only => :destroy

  def new
    @user = User.new
    @title = "Sign up"
  end

  def index
    @title = "All users"
    @users = User.order(:id).page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page params[:page]
    @title = @user.name
    @dates = @user.dates.map {|elem| elem.calendar_date}
    if current_user?(@user)
      @micropost = Micropost.new
    end
  end


  def create
   @user = User.new(params[:user])
   if @user.save
     sign_in @user
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user
   else
    @title = "Sign up"
    render 'new'
   end
  end

  def edit
    @title = "Edit user"
  end

  def events_for
    @user = User.find(params[:id])
    @microposts = @user.microposts.events_for(Date.new(params[:year].to_i,params[:month].to_i,params[:day].to_i)).page params[:page]
    respond_to do |format|
      format.html {render 'shared/microposts' }
      format.js
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private




    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
