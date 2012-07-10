class Todo < ActiveRecord::Base

  validates :body, presence: true

  attr_accessible :body, :completed

end
