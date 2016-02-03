class Transaction < ActiveRecord::Base
  belongs_to :service

  def self.prepareTransfert(from, to, amount, service)
  	transaction_params = {}
  	transaction_params[:debit] = from
  	transaction_params[:receive] = to
  	transaction_params[:amount] = amount
  	transaction_params[:service_id] = service
  	transaction_params[:status] = false
  	@transaction = Transaction.new
  	@transaction.save(transaction_params)
  end
  def self.execute(id)
  	@transactions = Transaction.where(:service_id => id).all
  	@transactions.each do |transaction|
  		if !transaction.status

	  		# On débite le débiteur 
	  		@debiteur = transaction[:debit]
	  		@debiteur = User.find @debiteur
	  		@debiteur[:amount] = @debiteur[:amount] - transaction[:amount]
	  		@debiteur.save

	  		# On crédite le créditeur 
	  		@crediteur = transaction[:receive]
	  		@crediteur = User.find @crediteur
	  		@crediteur[:amount] = @crediteur[:amount] + transaction[:amount]
	  		@crediteur.save

	  		# On valide la transaction
	  		transaction[:status] = true
	  		Transaction.save(transaction)
	  	end
  	end

  end
end
