class ProductChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "product_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # custom method for starting streaming for one product,
  # called by client on the product page via JS:
  # perform('listen', {...data object...});
  def listen(data)
    stop_all_streams
    stream_for data['product_id']
  end
end
