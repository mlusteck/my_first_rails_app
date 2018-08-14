class AddTimestampsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :created_at, :datetime, null: false, default: 100.days.ago
    add_column :orders, :updated_at, :datetime, null: false, default: 100.days.ago
  end
end
