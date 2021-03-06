class User < ApplicationRecord
	has_and_belongs_to_many :lists, dependent: :destroy
	attr_accessor :remember_token

	# the self is optional here because it is inside the User model, so email = email.downcase is the same thing
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 30 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

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

  	def authenticated?(remember_token)return false if remember_digest.nil?
  		
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

  	# Forgets a user.
  	def forget
    	update_attribute(:remember_digest, nil)
  	end

end
