const mariadb = require('mariadb');

module.exports.execute = async (query, params, pool) => {
    let conn;
    try {
        conn = await pool.getConnection();
        return await conn.query(query, params);        
    } catch (err) {
        throw err;
    } finally {
        if(conn) conn.end();
    }
};
