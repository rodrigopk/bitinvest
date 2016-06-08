class UserMailer < ApplicationMailer

  
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "BitInvest - Ativação de conta"
  end

  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "BitInvest - Redefinição de senha"
  end
end
