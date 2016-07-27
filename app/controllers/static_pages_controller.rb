class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		#Coin.order(:rank)[0..9]
  	  @users = User.all.sort_by{|user| user.total_value_fiat}.reverse![0..9]
  	end
  end

  def help
  end

  def contact
  end
end