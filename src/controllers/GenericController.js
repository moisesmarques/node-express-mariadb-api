module.exports = (app) => {

  const TestRepository = require('../repositories/UserRepository');

  app.get('/api/v1/', async (req, res) => {
    return await TestRepository.get()
                        .then(result => success(result, res))
                        .catch(err => error(err, res));
  });

  app.post('/api/v1/', async (req, res) => {
    return await TestRepository.post(req.body)
                        .then(result => success(result, res))
                        .catch(err => error(err, res));
  });

  const success = (result, res) => res.status(200).json(result);

  const error = (error, res) => {
    console.log(error);
    res.status(501).json({ message: 'Something when wrong.' });                           
  };

}