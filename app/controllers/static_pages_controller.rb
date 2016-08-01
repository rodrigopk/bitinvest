class StaticPagesController < ApplicationController
  
  def home 
    @users = User.order('level DESC')[0..9]
  end

  def help
  end

  def contact
  end
end