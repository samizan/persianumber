

defaultSettings = "fa"

$.fn.persiaNumber = (settings) ->

  convert = (obj, range) ->
    obj.find('*').andSelf().contents().each ->
      if @nodeType == 3 and @parentNode.localName != 'style' and @parentNode.localName != 'script'
        @nodeValue = @nodeValue.replace(@nodeValue.match(/[0-9]*\.[0-9]+/), (txt) ->
          txt.replace /\./, ','
        )
        @nodeValue = @nodeValue.replace(/\d/g, (v) ->
          String.fromCharCode v.charCodeAt(0) + range
        )
      return
    return

  if typeof settings == 'string' and settings.length > 0
    defaultSettings = settings
  range = 1728
  if settings == 'ar'
    range = 1584
  window.persiaNumberedDOM = this
  convert this, range
  $(document).ajaxComplete ->
    thisObj = window.persiaNumberedDOM
    convert thisObj, range
    return
  return


origParseInt = parseInt

parseInt = (str) ->
  str = str and str.toString().replace(/[\u06F0\u06F1\u06F2\u06F3\u06F4\u06F5\u06F6\u06F7\u06F8\u06F9]/g, (v) ->
    String.fromCharCode v.charCodeAt(0) - 1728
  ).replace(/[\u0660\u0661\u0662\u0663\u0664\u0665\u0666\u0667\u0668\u0669]/g, (v) ->
    String.fromCharCode v.charCodeAt(0) - 1584
  ).replace(/[\u066B]/g, '.')
  origParseInt str

origParseFloat = parseFloat

parseFloat = (str) ->
  str = str and str.toString().replace(/[\u06F0\u06F1\u06F2\u06F3\u06F4\u06F5\u06F6\u06F7\u06F8\u06F9]/g, (v) ->
    String.fromCharCode v.charCodeAt(0) - 1728
  ).replace(/[\u0660\u0661\u0662\u0663\u0664\u0665\u0666\u0667\u0668\u0669]/g, (v) ->
    String.fromCharCode v.charCodeAt(0) - 1584
  ).replace(/[\u066B]/g, '.')
  origParseFloat str
  

$(document).on 'page:update', ->
  $('.recipes').persiaNumber('ar')
  return