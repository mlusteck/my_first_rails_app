class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
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

  def price_in_euro
    price_in_cents.to_d*0.01
  end
end
