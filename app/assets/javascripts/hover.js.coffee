
mask = $ '<div>',
  id: 'mask'
  css:
    background: 'rgba(0, 0, 0, 0.5)'
    position: 'absolute'
    width: '100%'
    height: '100%'
    left: 0
    top: 0
    color: "white"


mouseIn = ( e )->
  $this = $(this)
  id = $this.data 'id'

  $.get "/exhibitions/#{id}/mask", ( response )->
    mask.html( response )
    $this.append(mask)
    mask.show()

mouseOut = ( e )->
  $this = $(this)
  mask.hide()

$( document ).ready ()->
  $('li.exhibition').hover(mouseIn)