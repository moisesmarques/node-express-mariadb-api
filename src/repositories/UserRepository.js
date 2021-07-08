const GenericRepository = require('./GenericRepository');

module.exports.get = () => {
    return GenericRepository.execute(`
    SELECT *
    FROM users    
    `);
}

module.exports.post = (user) => {
    return GenericRepository.execute(`
    INSERT INTO users 
    (id
        , old_id
        , create_date
        , last_modified_date
        , user_type
        , display_name
        , avatar_big
        , avatar_small
        , is_deleted
        , api_key
        , firstname
        , lastname
        , phone_number
        , referred_by_id
        , socket_id
        , online_status
        ) VALUES ( NULL
            , NULL
            , current_timestamp()
            , '0000-00-00 00:00:00.000000'
            , ''
            , ''
            , NULL
            , NULL
            , '0'
            , ''
            , NULL
            , NULL
            , NULL
            , NULL
            , NULL
            , '0'
            )
    `);
}