class Post < ActiveRecord::Base
	has_many :pictures, as: :imageable, dependent: :destroy

	belongs_to :staff
	belongs_to :ticket
	belongs_to :status

	validates :body, presence: true

	accepts_nested_attributes_for :pictures
end
