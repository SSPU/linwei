# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#star").hide()
  $("#pushcol").imagesLoaded ->
    height = $("#push img").height() - 120
    style = "top: " + height + "px; left: -72px; position: absolute"
    $("#star").attr("style", style)
    $("#star").show()
