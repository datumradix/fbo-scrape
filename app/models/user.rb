class User < ActiveRecord::Base
  has_many :roles
  belongs_to :team
  acts_as_authentic do |c|
  	c.crypto_provider = Authlogic::CryptoProviders::Sha512  #BCrypt  #Sha512
  end

  def role_symbols
  	roles = Role.all

	  roles.map do |role|
	    role.title.underscore.to_sym
	  end
	end
end
