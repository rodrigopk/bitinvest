scaleVideoContainer = ->
  height = $(window).height() + 5
  unitHeight = parseInt(height) + 'px'
  $('.homepage-hero-module').css 'height', unitHeight
  return

initBannerVideoSize = (element) ->
  $(element).each ->
    $(this).data 'height', $(this).height()
    $(this).data 'width', $(this).width()
    return
  scaleBannerVideoSize element
  return

scaleBannerVideoSize = (element) ->
  windowWidth = $(window).width()
  windowHeight = $(window).height() + 5
  videoWidth = undefined
  videoHeight = undefined
  console.log windowHeight
  $(element).each ->
    videoAspectRatio = $(this).data('height') / $(this).data('width')
    $(this).width windowWidth
    if windowWidth < 1000
      videoHeight = windowHeight
      videoWidth = videoHeight / videoAspectRatio
      $(this).css
        'margin-top': 0
        'margin-left': -(videoWidth - windowWidth) / 2 + 'px'
      $(this).width(videoWidth).height videoHeight
    $('.homepage-hero-module .video-container video').addClass 'fadeIn animated'
    return
  return

ready = ->
  scaleVideoContainer()
  initBannerVideoSize '.video-container .poster img'
  initBannerVideoSize '.video-container .filter'
  initBannerVideoSize '.video-container video'
  $(window).on 'resize', ->
    scaleVideoContainer()
    scaleBannerVideoSize '.video-container .poster img'
    scaleBannerVideoSize '.video-container .filter'
    scaleBannerVideoSize '.video-container video'
    return
  return

$(document).ready(ready)
$(document).on('page:load', ready)