"use strict";

const request = require("superagent");

const btn = document.getElementsByClassName("jobs__delete");

const deleteData = function() {
  const el = this.parentNode;
  if(confirm("delete?")) {
    request.post("/delete")
      .send({id: el.getAttribute("data-id")})
      .type("form")
      .end(function(err, res) {
        if(err) {
          console.log("error");
        } else {
          el.parentNode.removeChild(el);
        }
      })
  }
};
Array.from(btn).forEach(function(el) {
  el.addEventListener("click", deleteData);
});