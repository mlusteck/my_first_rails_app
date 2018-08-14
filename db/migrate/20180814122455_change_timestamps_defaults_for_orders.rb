class ChangeTimestampsDefaultsForOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:orders, :created_at, from: 100.days.ago, to:nil)
    change_column_default(:orders, :updated_at, from: 100.days.ago, to:nil)
  end
end
