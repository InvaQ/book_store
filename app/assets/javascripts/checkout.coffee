$(document).on "turbolinks:load", ->
  $('#use_billing').click ->
    $('#shipping_from').slideToggle()