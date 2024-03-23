const UserRepository = require('../data/database/UserRepo');

const userRepository = new UserRepository();

exports.registerUser = (req, res) => {
  userRepository
    .registerUser(req, res)
    .then((message) => {
      res.status(201).json({ message }); // Registration was successful, return the success message
    })
    .catch((error) => {
      res.status(400).json({ message: error }); // Registration encountered an error, return the error message
    });
};

exports.loginUser = (req, res) => {
  userRepository.loginUser(req, res);
};

/*
get
exports.getSameUsers = (req, res) => {
  userRepository.getSameUsers(req, res);
};


//get
exports.getUsersContributions = (req, res) => {
  userRepository.getUsersContributions(req, res);
};
*/