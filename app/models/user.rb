class User < ActiveRecord::Base
  #include Rails.application.routes.url_helpers
  require 'csv'
  
  has_many :wallets, dependent: :destroy
  has_many :user_metrics, dependent: :destroy

  after_initialize :init
  before_save :level_up_check, if: :xp_changed?
  
  attr_accessor :remember_token, :activation_token
  attr_accessor :remember_token, :activation_token, :reset_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  before_save   :downcase_email
  before_create :create_activation_digest
  
  # property validation
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  # password
  has_secure_password
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    #http://www.leemunroe.com/send-automated-email-ruby-rails-mailgun/
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def create_initial_wallets

    Coin.order(:rank)[0..9].each do |coin|
       self.wallets.create!(units: 10.0, coin_id: coin.id)   
    end
    self.wallets.create!(units: 10000.0, coin_id: Coin.last.id)  
    
  end
  
  def get_wallet_by_coin(coin_id)
    self.wallets.find_by coin_id: coin_id
  end
  
  def get_fiat_wallet
    self.wallets.each do |wallet|
      if wallet.coin.is_fiat?
        return wallet
      end
    end
  end
  
  def remove_empty_wallets
    self.wallets.each { |wallet| 
      if wallet.units == 0
        logger.info "\n Destroying wallet: #{wallet.coin.name}\n"
        wallet.destroy
      end
    }
  end

  def total_value_fiat
    value = 0
    self.wallets.each { |wallet|
      value += wallet.coin.value*wallet.units
    }
    return value
  end

  def total_value_bitcoin
    value = 0
    self.wallets.each { |wallet|
      value += wallet.coin.bitcoin_value*wallet.units
    }
    return value
  end

  def reward_xp(reward)
    rewards = {:small => 100, :medium =>200 ,:big => 500}
    if rewards.key?(reward)
      self.increment!(:xp, rewards[reward])
      level_up_check
    end
  end

  def save_metric
    
    metrics_per_day = 168
    if self.user_metrics.size == metrics_per_day
      self.user_metrics.first.destroy
    end
      self.user_metrics.create!(wallet_value: self.total_value_fiat)
  end

  def self.to_csv 
    header = %w{name email}    
    filename = File.join Rails.root ,'csv/users.csv'

    CSV.open(filename, "w", headers: true) do |csv|
      csv << header

      all.each do |user|
        csv << user.attributes.values_at(*header)
      end
    end
  end
  
  private

    #initialize statistic fields
    def init
      self.daily_volume ||= 0.0
      self.daily_transactions ||= 0.0
      self.daily_wallet_views ||= 0
    end
    
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def level_up_check
      if self.level < 20
        next_level_xp = (self.level)*1000
        if self.xp >= next_level_xp
          self.update!(level: self.level+1,
                        xp: self.xp-next_level_xp)
        end
      end  
    end
  
end
