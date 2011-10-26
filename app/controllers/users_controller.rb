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


   @received_microposts = []
   if  @user.received_microposts.present?
    @user.received_microposts.each do |rpm|
         post = Micropost.find(rpm.micropost_id)
         @received_microposts << {:author_name => post.user.name,
          :content => post.content,
          :created_at => post.created_at}
    end
   end


   @title = @user.name
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
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  
  
  def update
    @user = User.find(params[:id])
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
