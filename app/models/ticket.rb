class Ticket < ActiveRecord::Base
	has_many :pictures, as: :imageable
	belongs_to :status
	belongs_to :stuff

	validates :customer_name, :customer_email, :subject, :body, presence: true

	include IdGeneration

	before_create do
		self.token = self.class.generate_id
	end	

	before_save do
		self.status_id = Status.first.id
	end	
end
