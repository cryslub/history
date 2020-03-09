const mysql = require('mysql2')
const mybatisMapper = require('mybatis-mapper')

const connection = mysql.createConnection({
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

mybatisMapper.createMapper([ __dirname+'/data.xml' ]);

console.log("connected");
const format = {language: 'sql', indent: '  '};

exports.query = function(id,param,callback){
	var statement = mybatisMapper.getStatement('data', id, param, format);
	console.log(statement);
	connection.query(statement, function(err, results, fields) {
		 if (err) throw err;
		 const ret = JSON.stringify(results);
		// console.log(ret);
		 callback(ret);
	});
}

