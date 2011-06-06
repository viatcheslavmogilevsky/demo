class MicropostsController < ApplicationController
  

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
   @micropost.destroy
   redirect_back_or root_path
  end
end
