class Ticket < ActiveRecord::Base
	include Rakismet::Model
	include ActiveModel::Dirty
	include IdGeneration
	include TrackChanges

	paginates_per 5
	
	has_many :pictures, as: :imageable
	has_many :posts	
	has_many :histories
	belongs_to :status
	belongs_to :staff
	belongs_to :taken_tickets, :class_name => 'Staff', :foreign_key => 'taken_staff_id'
	belongs_to :department

	accepts_nested_attributes_for :pictures

	validates :customer_name, :customer_email, :subject, :body, presence: true

  	rakismet_attrs author: :customer_name, author_url: :permalink, author_email: :customer_email, content: :body, 
  	permalink: :permalink, user_ip: :remote_ip, user_agent: :user_agent, referrer: :referrer
	
	SECTIONS = {
		unassigned: "New Unassigned Tickets",
		opened: "Open Tickets",
		on_hold: "On Hold Tickets",
		closed: "Closed Tickets"
	}
	
	def init_sp(permalink, request)
		self.permalink = permalink
		self.remote_ip = request.remote_ip
		self.user_agent = request.env["HTTP_USER_AGENT"], 
		self.referrer = request.env["HTTP_REFERER"]
	end

	before_create do
		self.token = self.class.generate_id
	end	

	before_save do |saved|
		s = Staff.find_by_email(customer_email)

		unless s
			pass = "q2s3d4f5f5g6g6"	
			Staff.new(name: self.customer_name, email: self.customer_email, password: pass, password_confirmation: pass, role: 'customer').save
		end

		if self.status_id_changed?
			track_changes("Status changed from <b>#{Status.find(self.status_id_was || 1).title}</b> to <b>#{self.status.try(:title)}</b>")
		end

		if self.taken_staff_id_changed?
			track_changes("Taken ownership by <b>#{self.taken_tickets.name}</b>")
		end

		self.status = Status.first if !self.status_id_was
		self.staff = s

	end

	scope :with_department, ->(staff) { staff.department_id and staff.member? ? where(department_id: staff.department_id) : all }
	scope :unassigned, -> { where(taken_staff_id: nil) }
	scope :on_hold, -> { joins(:status).where("taken_staff_id is not null and statuses.short_title in ('on_hold')") }
	scope :opened, -> { joins(:status).where("taken_staff_id is not null and statuses.short_title not in ('on_hold', 'cancelled', 'completed')") }
	scope :closed, -> { joins(:status).where("statuses.short_title in ('cancelled', 'completed')") }
end
