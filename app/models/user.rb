class User < ActiveRecord::Base
  has_many :roles
  belongs_to :team
  acts_as_authentic do |c|
  	c.crypto_provider = Authlogic::CryptoProviders::Sha512  #BCrypt  
  end

  def role_symbols
  	roles = Role.all

	  roles.map do |role|
	    role.title.underscore.to_sym
      #role.title.downcase.gsub(/ /, "_").to_s.to_sym
	  end
	end

  def deliver_password_reset_instructions
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

end
