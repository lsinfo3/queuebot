cheerio = require('cheerio')

module.exports = (robot) ->
  robot.respond /mensa (.*)/i, (msg) ->
  	date = msg.match[1].trim()
  	mensa(msg, date)

mensa = (msg, date) ->
  msg
    .http("http://www.studentenwerk-wuerzburg.de/wuerzburg/essen-trinken/speiseplaene.html?tx_thmensamenu_pi2%5Bmensen%5D=7&tx_thmensamenu_pi2%5Baction%5D=show&tx_thmensamenu_pi2%5Bcontroller%5D=Speiseplan&cHash=efe40abc8afe9bcac3abf914dff9d943")
    .get() (err, res, body) ->
      msg.send "#{getMenu body, date}"
  	
getMenu = (body, date) ->
  $ = cheerio.load(body)
  $("div[data-day~='#{ date }'] .left .title").map( (i, el) -> $(el).text()).get().join(", ")
