$(document).ready(function () {
window.addEventListener("message", function (event) {
  let data = event.data;

  if (data.mapoutline == true) {
    $(".outline").show();
  } else if (data.mapoutline == false) {
    $(".outline").hide();
  }

})})
