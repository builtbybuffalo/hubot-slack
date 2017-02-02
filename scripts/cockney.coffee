# Description:
#   Responds with cockney rhyming slang

phrases = require "./data/cockney.json"
util = require('util')

module.exports = (robot) ->
  triggers = Object.keys(phrases)
  regex = new RegExp "\\b(#{triggers.join('|')})\\b", 'gi'
  robot.hear regex, (res) ->
    rep = res.message.text.replace regex, (match) ->
      "*#{phrases[match.toLowerCase()]}*"

    unless rep.indexOf(">>>") > -1
      rep = ">>> #{rep}"
    res.send "Cockney Ambassador\r\n\r\n#{rep}"
