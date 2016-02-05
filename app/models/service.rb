# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  place       :string
#  transport   :string
#  done        :boolean
#  price       :float
#  date        :datetime
#  code        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  nbpart      :integer
#  longitude   :string
#  latitude    :string
#  category_id :integer
#

class Service < ActiveRecord::Base
  belongs_to :user, dependent: :destroy 
  belongs_to :category
  has_and_belongs_to_many :users, dependent: :destroy 
  has_many :transactions, dependent: :destroy 
  validates :title, presence: true
  validates :nbpart, presence: true
  validates :category_id, presence: true

  def terminate
  	done = true
  	save
  	transactions.each do |transaction|
  		transaction.execute
  	end
  end

  def belongs_to?(a_user)
    user == a_user
  end
end
