var express = require('express');
var request = require('request');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Groundhog' });
});

router.post('/weather', function(req, res, next) {  
  
  let apiKey = '4fe672285d5a897253d8bef26bc3d059';
  let city = req.body.city || 'portland';
  console.log(JSON.stringify(req.body));
  //let url = `http://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=${apiKey}`
  let url = `http://localhost:5000/weather/${city}`
  console.log(url);

  request(url, function (err, response, body) {
    if(err){
      console.log('error:', error);
    } else {
      let weatherres = JSON.parse(body)
      let message = `It's ${weatherres.main.temp} degrees in ${weatherres.name}!`;      
      console.log(message);
      res.render('weather', { temp: `${weatherres.main.temp}`, city: `${weatherres.name}`});
    }
  });
});

module.exports = router;
