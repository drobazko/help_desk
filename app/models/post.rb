class Post < ActiveRecord::Base
	has_many :pictures, as: :imageable, dependent: :destroy

	belongs_to :postable, polymorphic: true
	belongs_to :ticket
	belongs_to :status

	validates :body, presence: true
end
