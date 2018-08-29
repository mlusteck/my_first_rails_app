class CommentUpdateJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(comment)
    product = comment.product
    ProductChannel.broadcast_to(
      product.id,
      average_rating: product.average_rating,
      comment_path: product_comment_path(product, comment)
    )
  end
end
