class ChangePriceToPriceInCentsInProducts < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  def using_sqlite3?
    ActiveRecord::Base.connection.instance_values["config"][:adapter] == "sqlite3"
  end

  def sqlite3_turn_off_foreign_keys
    if using_sqlite3?
      execute("PRAGMA foreign_keys = OFF")
    end
  end

  def sqlite3_turn_on_foreign_keys
    if using_sqlite3?
      execute("PRAGMA foreign_keys = ON")
    end
  end

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

    sqlite3_turn_off_foreign_keys
    ActiveRecord::Base.transaction do
      if using_sqlite3?
        say "Test: " + execute("PRAGMA foreign_keys").to_s
      end
      change_column :products, :price, :integer, using: 'price::integer'
      rename_column :products, :price, :price_in_cents
    end
    sqlite3_turn_on_foreign_keys
  end

  def down
    sqlite3_turn_off_foreign_keys
    ActiveRecord::Base.transaction do
      rename_column :products, :price_in_cents, :price
      change_column :products, :price, :decimal, using: 'price::decimal'
    end
    sqlite3_turn_on_foreign_keys
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
