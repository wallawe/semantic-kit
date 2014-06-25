$ ->
  $("#card-form, #bank-account-form").hide()

  $(".preference-button #cc_button").on "click", ->
    $(".preference-button").hide()
    $("#card-form").toggle()

  $(".preference-button #bank_button").on "click", ->
    $(".preference-button").hide()
    $("#bank-account-form").toggle()

  $("input#cc_number").payment("formatCardNumber")
  $("input#cvc").payment("formatCardCVC")
  $("input#expiration").payment("formatCardExpiry")