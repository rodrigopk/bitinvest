class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  	  @users = User.all[0..9].sort_by{|user| user.total_value_fiat}
  	end
  end

  def help
  end

  def contact
  end
end