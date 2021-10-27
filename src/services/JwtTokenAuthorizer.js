
module.exports.authorize = authorize;

async function authorize(bearerToken){
    
    const jwt = require('jsonwebtoken');
    const secretKey = process.env.jwt_token_signing_key;
    
    return await jwt.verify((bearerToken || '').replace('Bearer ', '')
        , secretKey
        , function(err, decoded) {
            return !err;
        });

}