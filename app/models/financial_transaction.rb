class FinancialTransaction < ActiveRecord::Base

	def FinancialTransaction.execute(user_id, amount, comment)
      user = User.find(user_id)
      if user.balance.nil?
      	user.balance = 0
      end
      user.balance += amount
      user.save!
      FinancialTransaction.create(:datetime => Time.current, :user_id => user.id, :amount => amount, :comment => comment)
	end

end
