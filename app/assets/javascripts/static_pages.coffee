# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.dropdown-button').dropdown({constrainWidth: false })
  return

$(document).ready ->
  $('.target').pushpin
    top: 0
    offset: 0
  return