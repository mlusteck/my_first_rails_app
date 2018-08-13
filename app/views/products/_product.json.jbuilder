json.extract! product, :id, :name, :description, :image_url, :created_at, :updated_at, :colour, :price_in_cents
json.url product_url(product, format: :json)
