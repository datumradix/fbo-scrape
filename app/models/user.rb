class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :team
  acts_as_authentic do |c|
  	c.crypto_provider = Authlogic::CryptoProviders::Sha512  #BCrypt  
  end

  def role_symbols
	 #[role.title.underscore.to_sym]  #this fails on roles with more than one word
   [role.title.gsub(/ /, "_").downcase.to_sym]
	end

  def deliver_password_reset_instructions
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

end
