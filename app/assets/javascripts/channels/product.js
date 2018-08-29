App.product = App.cable.subscriptions.create("ProductChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("ProductChannel - Connected");
    this.isConnected = true;
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
    if( this.isConnected ) {
      console.log("*** Start listenToComments " + this.isConnected + " --- " + $("[data-product-id]").data("product-id"))
      return this.perform('listen',
        { product_id: $("[data-product-id]").data("product-id") }
      );
    }
    else {
      console.log("listenToComments: Waiting for connection...");
      setTimeout(function() { App.product.listenToComments()},100)
    }
  }
});

// when document is ready, start listening to product_channel
// for comments for this product-id
$(document).on('turbolinks:load', function() {
  App.product.listenToComments();
});
