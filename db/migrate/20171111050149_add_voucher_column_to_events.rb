class AddVoucherColumnToEvents < ActiveRecord::Migration[5.1]
  def change
  	add_column :events, :voucher, :string
  end
end
