# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  
@update_sell = (fiat,bitcoin,wallet_units) ->
  
  fiat_val = $("#units").val()*fiat
  bitcoin_val = $("#units").val()*bitcoin
  remaining_val = parseInt( wallet_units, 10 )-parseInt( $("#units").val(), 10 ) 
  
  $("#fiat").html fiat_val.toFixed(8)
  $("#bitcoin").html bitcoin_val.toFixed(8)
  $("#remaining").html remaining_val.toFixed(8)
  
  
@update_buy = (fiat,bitcoin,wallet_units) ->
  
  fiat_val = $("#units").val()*fiat
  bitcoin_val = $("#units").val()*bitcoin
  remaining_val = parseInt( wallet_units, 10 )+parseInt( $("#units").val(), 10 )  
  
  $("#fiat").html fiat_val.toFixed(8)
  $("#bitcoin").html bitcoin_val.toFixed(8)
  $("#remaining").html remaining_val.toFixed(8)

