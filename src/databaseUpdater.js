require('dotenv').config();
const fs = require("fs");
const path = require("path");
const MasterRepository = require("./repositories/MasterRepository");
const SlaveRepository = require("./repositories/SlaveRepository");

module.exports.run = async (db) => {

    let dir   = `migrations/${db}`;
    let files = fs.readdirSync(path.join(__dirname, dir));
    let repo  = db == 'write' ? MasterRepository : SlaveRepository;

    files.sort();

    try{
        for(let i = 0; i < files.length; i++)
            await executeQuery(files[i], dir, repo);
            
        console.log(`${db} database is up to date.`);
    }catch (err){
        console.log(err);
        console.log(`Found errors when updating "${db}" database.`);
        throw err;
    }
}

async function executeQuery(file, dir, repo){

    try {
        console.log(`Running ${file}`);
        const query = fs.readFileSync(path.join(__dirname, dir, file)).toString();
        await repo.execute(query, []);            
    } catch (err) {
        console.error(`Failed running ${file}`);        
        throw err;
    }
}

