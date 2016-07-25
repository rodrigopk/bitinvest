class UserMailer < ApplicationMailer

  
  def account_activation(user)
    @user = user
    html_output = render_to_string template: "user_mailer/account_activation"
    key = 'key-34de8a9000fba21a63ce3fc64f463edc'
    domain = 'bitinvestapp.com'
    RestClient.post "https://api:#{key}@api.mailgun.net/v3/#{domain}/messages",
      :from => "no-reply@bitinvestapp.com",
      :to => @user.email,
      :subject => "BitInvest - Ativação de conta",
      :html => html_output
    #mail to: user.email, subject: "BitInvest - Ativação de conta"

  end

  
  def password_reset(user)
    @user = user
    html_output = render_to_string template: "user_mailer/password_reset"
    key = 'key-34de8a9000fba21a63ce3fc64f463edc'
    domain = 'bitinvestapp.com'
    RestClient.post "https://api:#{key}@api.mailgun.net/v3/#{domain}/messages",
      :from => "no-reply@bitinvestapp.com",
      :to => @user.email,
      :subject => "BitInvest - Redefinição de senha",
      :html => html_output
    #mail to: user.email, subject: "BitInvest - Redefinição de senha"
  end
end

#File.open("#{Rails.root}/app/views/mailgun_mails/send_complex_message.html.erb", 'r').to_s.html_safe