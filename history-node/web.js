const express = require('express')
const fs = require('fs');

const data = require('./data')

const app = express()
const port = 8001




app.listen(port, () => console.log(`Example app listening on port ${port}!`))

app.use(express.static(__dirname+'/public'))

app.get('/', function (req, res) {

	fs.readFile(__dirname+'/public/viewer.html', function (err, html) {
	    if (err) {
	        throw err; 
	    }       
        res.writeHeader(200, {"Content-Type": "text/html"});  
        res.write(html);  
        res.end();  
	});

});

app.get('/data/scenario', function (req, res) {
	
	data.query('getScenario',{},function(result){
		  res.send(result);
	});
})

app.get('/data/faction', function (req, res) {
	
	data.query('getFaction',{},function(result){
		  res.send(result);
	});
})


app.get('/data/scenarioCities/:scenario', function (req, res) {
	
	data.query('getScenarioCities',req.params,function(result){
		  res.send(result);
	});
})

app.get('/data/road/scenario/:scenario', function (req, res) {
	
	data.query('getRoads',req.params,function(result){
		  res.send(result);
	});
})

app.get('/data/road/sub', function (req, res) {
	
	data.query('getRoadSubs',{},function(result){
		  res.send(result);
	});
})