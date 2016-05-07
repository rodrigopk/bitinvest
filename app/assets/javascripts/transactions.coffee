# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




#units = $("#units")
#change = $("#change") 


  #$("#change").textContent = $('#units').val()
  
@update = (fiat,bitcoin) ->
  
  fiat_val = $("#units").val()*fiat
  bitcoin_val = $("#units").val()*bitcoin
  
  $("#fiat").html fiat_val
  $("#bitcoin").html bitcoin_val
