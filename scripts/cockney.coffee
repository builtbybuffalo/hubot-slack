# Description:
#   Responds with cockney rhyming slang

phrases = require "./data/cockney.json"
util = require('util')

module.exports = (robot) ->
  triggers = Object.keys(phrases)
  regex = new RegExp "\\b(#{triggers.join('|')})\\b", 'gi'
  robot.hear regex, (res) ->
    regex = new RegExp "(\\b#{res.match[0]}\\b)", "gi"
    rep = res.message.text.replace regex, (match) ->
      "*#{phrases[match.toLowerCase()]}*"

    res.send "Cockney Ambassador\r\n\r\n>>> #{rep}"
