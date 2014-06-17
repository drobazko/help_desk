class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets
  has_one :taken_tickets, :class_name => 'Ticket', :foreign_key => 'taken_staff_id'

  has_many :posts


  belongs_to :department

  def you
  	"#{name} (#{email})"
  end

  def admin?
    role == 'admin'
  end

  def customer?
    role == 'customer'
  end

  scope :not_customer, -> { where.not(role: :customer) }
  scope :not_admin, -> { where.not(role: :admin) }
end

