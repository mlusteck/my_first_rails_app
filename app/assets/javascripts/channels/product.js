App.product = App.cable.subscriptions.create("ProductChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    //$(".alert.alert-info").show();
    $(".alert.alert-info").slideDown();
    setTimeout( function() {
      $(".alert.alert-info").slideUp();
      //$(".alert.alert-info").hide();
    }, 3000);
    $.get(data.comment_path);
    //$("#comments .product-reviews").prepend(data.comment);
    //changeAverageRating(data.average_rating);
    //refreshRatyRating();

  },

  listenToComments: function() {
    alert("Listening to comments! " + $("[data-product-id]").data("product-id"));
    return this.perform('listen',
      { product_id: $("[data-product-id]").data("product-id") }
    );
  }
});

// when document is ready, start listening to product_channel
// for comments for this product-id
$(document).on('turbolinks:load', function() {
  App.product.listenToComments();
});
