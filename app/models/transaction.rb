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

class Transaction < ActiveRecord::Base
  belongs_to :service
  belongs_to :worker, class_name: 'User'

  def execute
    # Pay everyone
    service.user.debit service[:price]
    worker.credit service[:price]
    done = true
    save
  end
end
