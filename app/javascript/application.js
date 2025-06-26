import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "jquery"
import "select2"



document.addEventListener("turbo:load", function() {
    $('.tag-select').select2({
        placeholder: "Select tags...",
        allowClear: true,
        width: '100%'
    });
});