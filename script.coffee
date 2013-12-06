messages = 
  'betahive': 'Merry Christmas Guys! Well done with Pingle so far and thanks for getting me involved in such an exciting project! Good luck for next year! <br> Anders'
  'kaldor': 'Merry Christmas To All at Kaldor! Yet another great year for Pugpig! Well done!<br> Anders'
  'agentivity': 'Merry Christmas Ed and Riaan, hope you have a great New Year! <br> Anders'
  'measured': 'Merry Christmas Sam and Max! Well done on a great year, I’m excited about the next one!<br> Anders'
  'condiment': 'Merry Christmas Condiment, hope the New Year treats you well! <br> Anders'
  'ito': 'Merry Christmas Ito! Looking forward to working with you in the New Year! <br> Anders'
  'pcs': 'Merry Christmas to all at PCS! Thoroughly enjoyed working with you and looking forward to more next year!<br> Anders'
  'juju': 'Merry Christmas Alex and Sue! Hope you have a great time. Looking forward to more projects next year!<br> Anders'
  'error': 'Merry Christmas Guys! I thoroughly enjoyed working with you hope we can find some more projects in the New Year. Enjoy your break!<br> Anders'
  'faith': 'Merry Christmas to all at Faith, hope you have a great New Year! <br> Anders'
  'solstice': 'Merry Christmas to all at Solstice, hope we get a chance to work together soon! <br> Anders'
  'flumes': 'Merry Christmas Steve! Looking forward to seeing the progress of flumes next year!<br> Anders'
  'smart': 'Merry Christmas to all at Smart 421, enjoy the christmas break!<br> Anders'
  'defacto': 'Merry Christmas to all at De Facto, enjoy the christmas break! <br> Anders'
  'thatsbrave': 'Merry Christmas Vaughn and Co. Hope you have a good one!<br> Anders'
  'vm': 'Merry Christmas Alex, hope you have a great New Year!<br> Anders'
  'kl': 'Merry Christmas to all at Kingsland Linassi. I hope you have a great New Year!<br> Anders'
  'rtc': 'Merry Christmas to all at Real Time Content. I hope you have a great New Year!<br> Anders'
  'crafted': 'Merry Christmas to all at Crafted. I hope you have a great New Year!<br> Anders'
  'fesuffolk': 'Merry Christmas FESuffolk gang! Thanks for your support this year!<br> Anders'
  'iprug': 'Merry Christmas IPRUG Crew! Looking forward to more burgers in the New Year (and ruby)<br> Anders'
  'alexd': "Merry Christmas Alex! Hope you have a great one!<br> Anders"
  'default': "Merry Christmas <br> from Anders!"

class Drawer
  constructor: (@app)->
    $(@app).on 'resized', @resize
    @canvas = $('canvas')[0]
    @width = 0
    @height = 0
    @x = 0
    @y = 0
    @size = 16
    @ctx = @canvas.getContext '2d'
    @draw()

  resize: (event, lowest)=>
    @lowest = lowest
    @canvas.width = @lowest
    @canvas.height = @lowest
    $('canvas').css 
      width: @lowest
      height: @lowest
    $('.canvas_container').css
      width: @lowest
      height: @lowest
      margin: "-#{@lowest/2}px"
    @x = 0
    @y = 0
    @limit = @lowest 
  
  draw: =>
    random = Math.random()
    if random < 0.5
      @ctx.fillStyle = "rgba(255,255,255,#{Math.random()})"
    if random > 0.5 and random < 0.8
      @ctx.fillStyle = "rgba(#{Math.ceil Math.random() * 255},0,0,1)"
    if random > 0.8
      @ctx.fillStyle = "rgba(0,#{Math.ceil Math.random() * 255},0,1)"
    if @y < @limit
      if Math.random() < 0.6
        @ctx.fillRect(@lowest/2 + @x - (@size/2) , @lowest/2 + @y - (@size/2), @size, @size)
        @ctx.fillRect(@lowest/2 - @x - (@size/2) , @lowest/2 + @y - (@size/2), @size, @size)
        @ctx.fillRect(@lowest/2 + @x - (@size/2) , @lowest/2 - @y - (@size/2), @size, @size)
        @ctx.fillRect(@lowest/2 - @x - (@size/2) , @lowest/2 - @y - (@size/2), @size, @size)
      @x += @size
      if @x > @limit
        @limit -= @size
        @x = 0
        @y += @size
    window.requestAnimationFrame @draw


class Writer
  constructor: (@app)->
    $(@app).on 'newmessage', @update
  update: (event, message)->
    $('.greeting').html(message)

class Reader
  constructor: (@app)->
    @updateMessage()
    $(window).on 'hashchange', @updateMessage
  
  updateMessage: =>
    key = window.location.hash.substring 1
    if messages[key]
      @message = messages[key]
    else
      @message = messages['default']
    $(@app).trigger 'newmessage', @message

class Resizer
  constructor: (@app)->
    $(window).on 'resize', @resize
    @counter = 3
    @resize()

  resize: =>
    @counter += 1
    if @counter > 3
      $(@app).trigger 'resized', Math.min $(window).width(), $(window).height()
      @counter = 0

class App
  constructor: ->
    @drawer = new Drawer @
    @writer = new Writer @
    @reader = new Reader @
    @resizer = new Resizer @

$ ->
  window.app = new App