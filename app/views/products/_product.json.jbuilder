json.extract! product, :id, :name, :description, :image_url, :created_at, :updated_at, :color
json.url product_url(product, format: :json)
