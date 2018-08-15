
module ProductsHelper
  def product_image_tag(product)
    if asset_exist? product.image_url
      image_tag product.image_url, class: "img-fluid", alt: product.name
    else
      image_tag "flyfish-800w.jpg", class: "img-fluid", alt: product.name
    end
  end

  def product_zoom_image_tag(product)
    if asset_exist? product.image_url
      image_tag product.image_url, class: "img-fluid img-zoom", alt: product.name, data_zoom_image: product.image_url
    else
      image_tag "flyfish-800w.jpg", class: "img-fluid img-zoom", alt: product.name, data_zoom_image: "flyfish-800w.jpg"
    end
  end

  def product_image_url(product)
    if asset_exist? product.image_url
      image_url product.image_url
    else
      image_url "flyfish-800w.jpg"
    end
  end

  def product_linked_image(product, href)
    link_to href do
      product_image_tag product
    end
  end
end
