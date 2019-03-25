var http = require('http');
var url = require('url');
var fs = require('fs');

var express = require("express");
var app = express();



//
//http.createServer(function handler(req, res) {
//	var q = url.parse(req.url, true);
//	  var filename = "." + q.pathname;
//	  fs.readFile(filename, function(err, data) {
//	    if (err) {
//	    	
//	    console.log(filename);
//	    console.log(q.pathname);
//	    console.log(req.url);
//	    
//	      res.writeHead(404, {'Content-Type': 'text/html'});
//	      
//	      return res.end("404 Not Found");
//	    }  
//	    res.writeHead(200, {'Content-Type': 'text/html'});
//	    res.write(data);
//	    return res.end();
//	  });
//}).listen(1337, '127.0.0.1');
//console.log('Server running at http://127.0.0.1:1337/');


var mysql = require('mysql');

var con = mysql.createConnection({
  host: "cryslub1.cafe24.com",
  user: "cryslub1",
  password: "Qazwsx12!",
  database: "cryslub1",
  typeCast: function (field, next) {

      if (field.type === 'BLOB') {
          return field.string();
      }
      return next();
  }
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

app.use(express.static('public'));
app.use('/js',express.static('./js'));
app.use('/json',express.static('./json'));

app.get('/scenario', function (req, res) {
   fs.readFile( "scenario.html", 'utf8', function (err, data) {
      res.end( data );
   });
})

app.get("/data/scenario.do", (req, res, next) => {
	con.query("select * from scenario", function (err, result, fields) {
	    if (err) throw err;
	    res.send(result);
	  });
	
// res.json(["Tony","Lisa","Michael","Ginger","Food"]);
});

var server = app.listen(8081, function () {
   var host = server.address().address
   var port = server.address().port
   console.log("Example app listening at http://%s:%s", host, port)
})
