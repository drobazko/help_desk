class Post < ActiveRecord::Base
	include TrackChanges
	has_many :pictures, as: :imageable, dependent: :destroy

	belongs_to :staff
	belongs_to :ticket
	belongs_to :status

	validates :body, presence: true

	accepts_nested_attributes_for :pictures

	before_create do
		track_changes("New Reply: #{self.body}")
	end
end
