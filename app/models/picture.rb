class Picture < ActiveRecord::Base
	mount_uploader :content, PictureUploader
	belongs_to :imageable, polymorphic: true
end
