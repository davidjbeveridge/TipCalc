class App.Home extends Spine.Controller
  events:
    "tap [data-action=number]": "addDigit"
    "tap [data-action=clear]":  "clear"
    "tap [data-action=calculate]": "calculateTip"
    "tap [data-action=toggle-keyboard]": "toggleKeys"

  constructor: ->
    super
    @active @render
  
  render: =>
    @html @view('home/index')
    $('#homescreen img').on 'tap click', (e) ->
      $(e.currentTarget).toggleClass('flipped')
  
  addDigit: (e) =>
    e.preventDefault()
    amtBox = $("#check-amount")
    oldVal = @getIntVal(amtBox.text()).toString()
    newVal = oldVal + $(e.currentTarget).data('value').toString()
    amtBox.text( @cleanZeros(newVal) )
  
  cleanZeros: (str) ->
    val = str.replace(/^0+([0-9]*)$/, '$1')
    val = "0" if val is ""
    val
  getIntVal: (str) ->
    Math.round(parseFloat(str))
  
  clear: (e) ->
    e.preventDefault()
    $('#check-amount, #tip-amount, #total').text('0')
    
  calculateTip: (e) ->
    e.preventDefault()
    percentage = $(e.currentTarget).data('percentage')
    checkAmt = @getIntVal($('#check-amount').text())
    tip = Math.round( checkAmt * (percentage / 100.0), 2)
    $('#tip-amount').text(tip)
    $('#total').text(checkAmt + tip)
  
  toggleKeys: (e) =>
    e.preventDefault()
    $(e.currentTarget).parent('li').siblings().toggle()
    $(e.currentTarget).find("span").toggleClass("flipped")