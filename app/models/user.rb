class User < ActiveRecord::Base
  belongs_to :role
  acts_as_authentic do |c|
  	c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def role_symbols
  	  roles = Role.all
	  roles.map do |role|
	    role.name.underscore.to_sym
	  end
	end
end
