messages = 
  'betahive': 'Merry Christmas Pete, Rob and Matt, I have thoroughly enjoyed working with you guys. Have a great new year!<br> Anders'
  'kaldor': 'Merry Christmas to all of you guys at Kaldor, I really hope your next year will be as successful as this one!<br> Anders'
  'agentivity': "Merry Christmas Riaan and Edd, I'm excited to see what you guys come up with in the new year!<br> Anders"
  'measured': "Merry Christmas Max and Sam, I'm amazed at how far you've come in such a short time! Looking forward to seeing some exciting projects in the new year.<br> Anders"
  'dan': "DAN! IT'S CHRISTMAS! Have a good one mate!<br> Anders"
  'tom': "Merry Christmas Tom, Jo, Milly and Dexter! Hope you have a great time together!<br> Anders"
  'condiment': 'MX C'
  'ito': 'MX ito'
  'pcs': 'MX pcs'
  'juju': 'MX juju'
  'error': 'MX Error'
  'faith': 'MX Faith'
  'kwiboo': 'kwiboo'
  'solstice': 'solstice'
  'flumes': 'steve'
  'thatsbrave': 'vaughn'
  'vm': "vector meldrew"
  'kl': "To all at Kingsland Linassi, Merry Christmas and a Happy New Year!<br> Anders"
  'rtc': "To all at Real Time Content, Merry Christmas and a Happy New Year!<br> Anders"
  'crafted': "To all at Crafted, Merry Christmas and a Happy New Year!<br> Anders"
  'fesuffolk': "Thanks so much to you all for attending FESuffolk. Looking forward to seeing you next year! Merry Christmas<br> Anders"
  'iprug': "Merry Christmas IPRUG! You've made a wayward JS Dev feel very at home!<br> Anders"
  'default': "Merry Christmas <br> from Anders!"
  'alexd': "Merry Chirstmas Alex! hope you have a great one!"

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