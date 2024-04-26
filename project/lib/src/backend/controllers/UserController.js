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

//new   sellarChat  AllUserName
exports.userName = (req, res) => {
  const { email } = req.query;
  console.log({email});

  userRepository.userName(email)
      .then((result) => {
          console.log({result});
      
          res.status(200).json(result);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
};


exports.sellarChat = (req, res) => {
  const { productName } = req.query;
  console.log({productName});

  userRepository.sellarChat(productName)
      .then((result) => {
          console.log({result});
      
          res.status(200).json(result);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
};
exports.AllUserName = (req, res) => {
  userRepository
    .AllUserName(req, res)
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



exports.Editprofile = (req, res) => {
  const { id, firstName, lastName, email, address, phoneNumber , gender } = req.body;
  userRepository
    .Editprofile(id, firstName, lastName, email, address, phoneNumber , gender)
    .then((message) => {
      res.status(200).json({ message }); // Return success message if profile updated successfully
    })
    .catch((error) => {
      res.status(500).json({ error }); // Return error message if update failed
    });
};
// new UpdatePass
exports.UpdatePass = (req, res) => {
  userRepository
    .UpdatePass(req, res)
    .then((message) => {
      console.log(message);
      res.status(201).json({ message }); 
    })
    .catch((error) => {
      res.status(400).json({ message: error }); 
    });
  }
  