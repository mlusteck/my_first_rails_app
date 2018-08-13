class ChangePriceToPriceInCentsInProducts < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def up
    say_with_time "Converting product prices to cents(integer)..." do
      Product.all.each do |p|
        if p.price
          p.price *= 100
        else
          p.price = 0
        end
        p.save
      end
    end

    if ActiveRecord::Base.connection.instance_of? ActiveRecord::ConnectionAdapters::SQLite3Adapter
      execute("PRAGMA foreign_keys = OFF")
    end
    ActiveRecord::Base.transaction do
      say "Test: " + execute("PRAGMA foreign_keys").to_s
      change_column :products, :price, :integer, using: 'price::integer'
      rename_column :products, :price, :price_in_cents
    end
    if ActiveRecord::Base.connection.instance_of? ActiveRecord::ConnectionAdapters::SQLite3Adapter
      execute("PRAGMA foreign_keys = ON")
    end
  end

  def down
    if ActiveRecord::Base.connection.instance_of? ActiveRecord::ConnectionAdapters::SQLite3Adapter
      execute("PRAGMA foreign_keys = OFF")
    end
    ActiveRecord::Base.transaction do
      rename_column :products, :price_in_cents, :price
      change_column :products, :price, :decimal, using: 'price::decimal'
    end
    if ActiveRecord::Base.connection.instance_of? ActiveRecord::ConnectionAdapters::SQLite3Adapter
      execute("PRAGMA foreign_keys = ON")
    end

    Product.reset_column_information

    say_with_time "Converting product prices to euros(dcimal)..." do
      Product.all.each do |p|
        if p.price
          p.price *= 0.01
        else
          p.price = 0.0
        end
        p.save
      end
    end
  end
end
