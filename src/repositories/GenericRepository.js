const mariadb = require('mariadb');

const pool = mariadb.createPool({
     host: process.env.HOST, 
     user: process.env.USER, 
     password: process.env.PASSWORD,
     connectionLimit: process.env.CONNECTION_LIMIT,
     database: process.env.DATABASE
});

module.exports.execute = (query) => {
    return new Promise((resolve, reject) => 
    pool.getConnection()
        .then(conn => conn.query(query)
            .then((rows) => resolve(rows))
            .catch(err => {
                conn.end();
                reject(err);
            })).catch(err => reject(err)));
};
