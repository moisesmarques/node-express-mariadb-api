const express           = require('express');
const cors              = require('cors');
const dotenv            = require('dotenv');
const GenericController = require('./Controllers/GenericController');

dotenv.config();

const app   = express();
const port  = process.env.PORT;

app.set('port', port);

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({
  extended: true
}));

GenericController(app);

app.listen(port, () => {
  console.log(`Running at port ${port}`)
});
  