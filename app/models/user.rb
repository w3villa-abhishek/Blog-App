class User < ApplicationRecord

	has_secure_password

	before_save :downcase_email #self referencing each object  #before save is a callback
	
	has_many :articles, dependent: :destroy #dependent destroys all the associated articles.

	

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :username, presence: true, uniqueness: true, length: {in: 5..15 }
	validates :email, presence: true, uniqueness: true,  
				length: {maximum: 50}, format: {with: VALID_EMAIL_REGEX}


	private 

	def downcase_email
		self.email = email.downcase
	end


end
