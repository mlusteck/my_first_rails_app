class Product < ApplicationRecord
  has_many :orders

  # to prevent case sensitive search (in postgres) convert all to lowercase
  def self.search(search_term)
    Product.where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
  end
end
