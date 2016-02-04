# == Schema Information
#
# Table name: transactions
#
#  id         :integer          not null, primary key
#  service_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  done       :boolean          default(FALSE)
#  worker_id  :integer
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
