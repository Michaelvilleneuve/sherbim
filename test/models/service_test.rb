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
#  statut      :boolean
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

require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
