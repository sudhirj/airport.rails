class Token < ActiveRecord::Base
  attr_accessible :token, :user
  validates_presence_of :token, :user
  belongs_to :user
end
