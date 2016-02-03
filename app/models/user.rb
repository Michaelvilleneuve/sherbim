class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      puts auth.info
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = 'http://graph.facebook.com/'+auth.uid.to_s+'/picture?width=360&height=210'
      user.age = auth.info.age
      user.points = 100
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end