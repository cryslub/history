import * as express  from "express";
import { Request, Response } from "express";
import * as fs  from "fs";
import * as db  from "./db";

const app = express()
const port:number = 8001




app.listen(port, () => console.log(`Example app listening on port ${port}!`))

app.use(express.static(__dirname+'/public'))

app.get('/', function (req:Request, res:Response) {

	fs.readFile(__dirname+'/public/viewer.html', function (err, html) {
	    if (err) {
	        throw err; 
	    }       
        res.writeHeader(200, {"Content-Type": "text/html"});  
        res.write(html);  
        res.end();  
	});

});

app.get('/data/scenario', async function (req:Request, res:Response) {
	
	res.json(await db.query('getScenario'));
})

app.get('/data/faction', async function (req:Request, res:Response) {
	
	res.json(await db.query('getFaction'));
})


app.get('/data/scenarioCities/:scenario', async function (req:Request, res:Response) {
	
	res.json(await db.query('getScenarioCities',req.params));
})

app.get('/data/road/scenario/:scenario', async function (req:Request, res:Response) {
	
	res.json(await db.query('getRoads',req.params));
})

app.get('/data/road/sub', async function (req:Request, res:Response) {
	
	res.json(await db.query('getRoadSubs'));

})