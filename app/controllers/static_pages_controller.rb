class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  	  #TO-DO: order by total_value
  	  @users = User.all.paginate(page: params[:page])
  	end
  end

  def help
  end

  def contact
  end
end
