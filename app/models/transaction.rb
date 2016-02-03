class Transaction < ActiveRecord::Base
  belongs_to :service

  def self.prepareTransfert(from, to, amount)

  end
  def self.execute(id)
  
  end
end
