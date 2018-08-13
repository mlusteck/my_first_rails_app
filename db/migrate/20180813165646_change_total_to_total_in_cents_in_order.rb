class ChangeTotalToTotalInCentsInOrder < ActiveRecord::Migration[5.2]
  def up
    say_with_time "Converting order totals to cents(integer)..." do
      Order.all.each do |o|
        if o.total
          o.total *= 100
        else
          o.total = 0
        end
        o.save
      end
    end

    change_column :orders, :total, :integer, using: 'total::integer'
    rename_column :orders, :total, :total_in_cents
  end

  def down
    rename_column :orders, :total_in_cents, :total
    change_column :orders, :total, :float, using: 'total::float'
    Order.reset_column_information

    say_with_time "Converting order totals to euros(float)..." do
      Order.all.each do |o|
        if o.total
          o.total *= 0.01
        else
          o.total = 0.0
        end
        o.save
      end
    end
  end
end
