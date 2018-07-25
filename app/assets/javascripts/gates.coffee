# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# $(document).on 'turbolinks:before-cache', ->
# $('body').hide()

# $(document).on "turbolinks:load", ->
# $('body').hide().delay(300).fadeIn('slow')


$(window).scroll -> 
    url = $('.pagination .next a').attr('href')
    
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 600
        $('.pagination').text("Loading...")
        $.getScript(url)
