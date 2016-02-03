class Service < ActiveRecord::Base
  belongs_to :user
  has_many :participants
  has_many :transactions
end
