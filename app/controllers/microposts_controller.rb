class MicropostsController < ApplicationController
  before_filter :authorized_user, :only => :destroy
  before_filter :authenticate
  

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      user = User.random.first
      user.receive_message(@micropost)
      flash[:success] = "Micropost created!"
#      while user.ign_items.include?(current_user.id)
#
#
#       user = User.random
#      end
      redirect_to root_path
    else
      @feed_items = []     
      render 'pages/home'
    end
  end

  def destroy
   @micropost.destroy
   redirect_to root_path
  end

  private

    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end

#    def condition?(user)
#      user.present? && !user.ign_items.include?(current_user)
#    end
end
