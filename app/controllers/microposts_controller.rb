class MicropostsController < ApplicationController
  before_filter :authorized_user, :only => :destroy
  before_filter :authenticate

  def edit
    @title = "Edit micropost"
    @micropost = Micropost.find(params[:id])
    respond_to do |format|
      format.html {session[:return_to] ||= request.referer}
      format.js
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(params[:micropost])
    #  respond_to do |format|
    #    format.html {
          flash[:success] = "Micropost updated."
          redirect_to session[:return_to]
    #    }
    #    format.js
   #   end
    else
      @title = "Edit micropost"
      render 'edit'
    end
  end

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    @event_id = params[:id]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end

  end

  def events_for
    @feed_items = Micropost.events_for(Date.new(params[:year].to_i,params[:month].to_i,params[:day].to_i)).page(params[:page])
    respond_to do |format|
      format.html { render 'shared/_feed' }
      format.js
    end
  end

  private

    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end

end
