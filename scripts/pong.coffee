# Description:
#   Throws down with a fool
#
# Commands:
#   hubot pong [user]
#   hubot leaderboard

_ = require "underscore"

module.exports = (robot) ->
  players = {
    hugo: ":hugo:"
    jaspertandy: ":jasper:"
    dan: ":dan:"
    alex: ":alex:"
    james: ":james:"
    paul: ":paul:"
    charlie: ":charlie:"
    max: ":max:"
    matotomax: ":max:"
    beto: ":beto:"
    colette: ":colette:"
  }

  matchup = (msg, user) ->
    if players[user] == undefined
      msg.send "I don't know #{user}"
    else
      opponents = _.clone players
      delete opponents[user]
      keys = Object.keys opponents
      opponent = opponents[keys[keys.length * Math.random() << 0]]
      msg.send "#{players[user].replace /:$/, "reverse:"} vs #{opponent}"

  robot.respond /leaderboard/i, (msg) ->
    robot.http("http://builtbybuffalo.com/pong")
      .get() (err, res, body) ->
        json = JSON.parse body
        message = []
        rootScore = null
        _.each json, (player) ->
          rootScore = player.display_elo if rootScore == null
          message.push "#{player.rank}. #{player.emoji} #{if player.rank == 1 then rootScore else "-#{rootScore - player.display_elo}"}"
        msg.send message.join("\n")

  robot.respond /pong ([^\s]+)/i, (msg) ->
    user = msg.match[1].replace /^@/, ""
    matchup msg, user

  robot.respond /pong$/i, (msg) ->
    matchup msg, msg.message.user.name

