class Ticket < ActiveRecord::Base
	include Rakismet::Model
	
	has_many :pictures, as: :imageable
	has_many :posts
	has_many :histories
	belongs_to :status
	belongs_to :staff
	belongs_to :department

	accepts_nested_attributes_for :pictures

	validates :customer_name, :customer_email, :subject, :body, presence: true
	
	def init_sp(permalink, request)
		self.permalink = permalink
		self.remote_ip = request.remote_ip
		self.user_agent = request.env["HTTP_USER_AGENT"], 
		self.referrer = request.env["HTTP_REFERER"]
	end

  	rakismet_attrs author: :customer_name, author_url: :permalink, author_email: :customer_email, content: :body, 
  	permalink: :permalink, user_ip: :remote_ip, user_agent: :user_agent, referrer: :referrer

	include IdGeneration

	before_create do
		self.token = self.class.generate_id
	end	

	before_save do
		self.status_id = Status.first.id
	end

	after_save do
		User.find_or_create_by(email: self.customer_email)
	end

	scope :unassigned, -> { where(staff_id: nil) }
	
end
