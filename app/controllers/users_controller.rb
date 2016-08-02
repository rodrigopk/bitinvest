class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:show,:edit, :update]
  before_action :empty_wallets, only: [:show]

  def show
    @user = User.find(params[:id])
    @level_progression = (@user.xp.to_f/(@user.level*1000).to_f)*100
    @user_title = "title_#{@user.level}".to_sym
    @wallets = []
    @fiat = []
    @user.wallets.each { |wallet|
      if wallet.coin.is_fiat?
        @fiat << wallet
      else
        @wallets << wallet
      end
    }
    @user.increment!(:daily_wallet_views)

    metrics = JSON.parse(@user.user_metrics.to_json)
    # highstocks deals with values in format [UNIX miliseconds,number]
    @values = metrics.collect {|hash| hash.values_at("wallet_value","created_at") }
    @values = @values.map {|value| value = [value[1].to_time.to_i*1000,value[0].to_f.round(2)] }
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_initial_wallets
      @user.send_activation_email
      flash[:info] = t(:please_check_email)
    end
    render 'new'
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = t(:profile_updated)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
    def empty_wallets
      current_user.remove_empty_wallets
    end
    
end
