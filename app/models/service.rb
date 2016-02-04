class Service < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :participants, dependent: :destroy 
  has_many :transactions, dependent: :destroy 
  validates :title, :presence => true
  validates :nbpart, :presence => true
  validates :category_id, :presence => true
end
