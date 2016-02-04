class Service < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :participants
  has_many :transactions
  validates :title, :presence => true
  validates :nbpart, :presence => true
end
