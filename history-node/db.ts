import * as mysql  from "mysql2";
import * as util  from "util";
import * as mybatisMapper  from "mybatis-mapper";

const pool = mysql.createPool({
		connectionLimit: 10,
	  host: '',
	  user: '',
	  password: '',
	  database: '',
	  typeCast: function (field, next) {
		 // console.log(field.type)
		  if (field.type === 'BLOB' || field.type === 'VAR_STRING') {
			  
	            return field.string();
	        }
	        return next();
	    }
	});

pool.getConnection((err, connection) => {
  if (err) {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('Database connection was closed.')
    }
    if (err.code === 'ER_CON_COUNT_ERROR') {
      console.error('Database has too many connections.')
    }
    if (err.code === 'ECONNREFUSED') {
      console.error('Database connection was refused.')
    }
  }

  if (connection) connection.release()

  return
})
	
pool.query = util.promisify(pool.query)	

mybatisMapper.createMapper([ __dirname+'/data.xml' ]);

console.log("connected");

export const query = async function(id:string,param?,callback?){
	if(param == undefined) param = {};
	
	var statement:string = mybatisMapper.getStatement('data', id, param);
	console.log(statement);
	return await pool.query(statement);
	 
};

