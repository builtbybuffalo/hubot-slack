# Description:
#   Responds with cockney rhyming slang

phrases = require "./data/cockney.json"

module.exports = (robot) ->
  triggers = Object.keys(phrases).map (item) -> item.toLowerCase()
  regex = new RegExp "(#{triggers.join('|')})", 'gi'
  robot.hear regex, (msg) ->
    msg.send "Cockney alert! #{phrases[msg.match[0].toLowerCase()]}"
