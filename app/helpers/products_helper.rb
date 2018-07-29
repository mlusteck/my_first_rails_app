
module ProductsHelper
  def product_image_tag(product)
    if asset_exist? product.image_url
      image_tag product.image_url, class: "img-fluid", alt: product.name
    else
      image_tag "flyfish-800w.jpg", class: "img-fluid", alt: product.name
    end
  end

  def product_linked_image(product, href)
    link_to href do
      product_image_tag product
    end
  end
end
