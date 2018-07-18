# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
    $().fadeIn 'slow'


$(window).scroll -> 
    url = $('.pagination .next a').attr('href')
    
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
        $('.pagination').text("Loading...")
        $.getScript(url)
        console.log($.getScript(url))
        