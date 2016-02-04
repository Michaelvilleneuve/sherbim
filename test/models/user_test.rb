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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
