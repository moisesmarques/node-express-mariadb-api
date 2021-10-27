(async function(){

    require('dotenv').config();
    const express = require('express');
    const cors = require('cors');
    const databaseUpdater = require('./databaseUpdater');
    const ReferralController = require('./controllers/ReferralController');

    try{        
        await databaseUpdater.run('write');
        await databaseUpdater.run('read');
    }catch(err){
        return;
    }   

    const app = express();
    const port = process.env.PORT;

    app.set('port', port);

    app.use(cors());
    app.use(express.json());
    app.use(express.urlencoded({
        extended: true
    }));


    ReferralController.build(app);

    app.listen(port, () => {
        console.log(`Running at port ${port}`)
    });

})();