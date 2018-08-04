class Product < ApplicationRecord
  has_many :orders
  has_many :comments
  validates :name, presence: true

  # to prevent case sensitive search (in postgres) convert all to lowercase
  def self.search(search_term)
    Product.where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
  end

  def average_rating
    comments.average(:rating).to_f
  end

  def highest_rating_comment
    comments.rating_desc.first
  end

  def lowest_rating_comment
    comments.rating_asc.first
  end

end
