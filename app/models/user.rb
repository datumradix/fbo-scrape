class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :team

  validates_presence_of :role_id, :team_id

  acts_as_authentic do |c|
  	c.crypto_provider = Authlogic::CryptoProviders::Sha512  #BCrypt  
  end

  def role_symbols
	 #[role.title.underscore.to_sym]  #this fails on roles with more than one word
   [role.title.gsub(/ /, "_").downcase.to_sym]
	end

  def self.find_by_username_or_email(login)
    User.find_by_username(login.downcase) || User.find_by_email(login.downcase)
  end

  def deliver_password_reset_instructions
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def welcome_new_user
    Notifier.welcome(self)
  end

end
