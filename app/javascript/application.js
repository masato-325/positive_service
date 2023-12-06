import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
Rails.start()
import "controllers"
import "bootstrap"
import "@popperjs/core"
import "consultations_new"

document.addEventListener("turbo:load", function() {
  var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
  var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
    return new bootstrap.Dropdown(dropdownToggleEl);
  });
});

