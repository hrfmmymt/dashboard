"use strict";

var $ = require("jQuery");

$(function() {
  $(".jobs__delete").on("click", function() {
    const el = $(this).parent();
    if(confirm("delete?")) {
      $.ajax({
        type: "POST",
        url: "/delete",
        data: {
          id: el.data("id")
        },
        success: function() {
          el.remove();
        }
      });
    }
  });
});