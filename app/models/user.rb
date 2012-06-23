class User < ActiveRecord::Base
  attr_accessible :login, :name
  validates_presence_of :login
  has_many :tokens

  def token
    last_token = tokens.last
    last_token ? last_token.token : nil
  end
end
