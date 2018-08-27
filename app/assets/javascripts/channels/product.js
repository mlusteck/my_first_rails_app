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
    }, 6000);
  }
});
