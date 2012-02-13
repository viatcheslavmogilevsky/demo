class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      #@feed_items = current_user.feed.page(params[:page])
      @feed_items = Micropost.order(:created_at).page params[:page]
      @dates = Micropost.may.map {|elem| elem.calendar_date}
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
   @title = "Help"
  end
end
