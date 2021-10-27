require('dotenv').config();
const mariadb = require('mariadb');
const GenericRepository = require('./GenericRepository');

const pool = mariadb.createPool({
     host: process.env.slave_db_host, 
     user: process.env.slave_db_username, 
     password: process.env.slave_db_password,
     connectionLimit: process.env.slave_db_connection_limit,
     database: process.env.slave_db_name,
     debug: false
});


module.exports.execute = async (query, params) => {
    return GenericRepository.execute(query, params, pool);
};