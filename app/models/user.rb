# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string
#  firstname        :string
#  description      :text
#  email            :string
#  phone            :string
#  age              :integer
#  points           :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string
#  uid              :string
#  oauth_token      :string
#  oauth_expires_at :datetime
#  image            :string
#  role             :string
#

class User < ActiveRecord::Base
  has_and_belongs_to_many :services
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      puts auth.info
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = 'https://graph.facebook.com/'+auth.uid.to_s+'/picture?width=360&height=210'
      user.age = auth.info.age
      user.points = 100
      user.role = 'customer'
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def debit(price)
    points -= price
    save
  end

  def credit(price)
    points += price
    save
  end
end
