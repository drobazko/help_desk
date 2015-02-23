class Department < ActiveRecord::Base
  has_many :staffs
  has_many :tickets
end
