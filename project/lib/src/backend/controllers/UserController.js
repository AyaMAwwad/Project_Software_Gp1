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

//exports.del

exports.deleteacountt = (req, res) => {
  const userId = req.body.userId; // Assuming the user ID is in the request body
  console.log('deleteacountt controller method invoked with userId:', userId);
  userRepository.deleteacountt(userId)
    .then((result) => {
      console.log(result);
      res.status(200).send(result);
    })
    .catch((error) => {
      console.error('Error:', error);
      res.status(500).send(error);
    });
};

exports.oldpassword = (req, res) => {
  const { email, oldPassword } = req.body;

console.log('oldpassword controller method invoked with email:', email);
console.log('oldpassword controller method invoked with oldPassword:', oldPassword);
  userRepository.oldpassword(email, oldPassword)
  .then((result) => {
    // If the old password matches the stored password, send success response
    if (result) {
      res.status(200).json({ message: 'Old password matches the stored password' });
    } else {
     
      res.status(401).json({ message: 'New password not matches the stored password' });
    }
  })
  .catch((error) => {
    
    console.error('Error checking old password:', error);
    res.status(500).json({ message: 'Internal server error' });
  });
};

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
  };

  ////// new 12/5 userInteraction
  exports.userInteraction = (req, res) => {
    userRepository
      .userInteraction(req, res)
      .then((message) => {
        res.status(200).json({ message }); 
      })
      .catch((error) => {
        res.status(500).json({ error });
      });
  };
  //// 15_MAY deliverydetials
  
exports.deliveryEmployee = (req, res) => {
  const { type } = req.query;
  console.log({type});

  userRepository.deliveryEmployee(type)
      .then((result) => {
          console.log({result});
      
          res.status(200).json(result);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
};

//deliveryFromSellar
exports.deliveryFromSellar = (req, res) => {
  const { productId } = req.query;
 

  userRepository.deliveryFromSellar(productId)
      .then((result) => {
          console.log({result});
      
          res.status(200).json(result);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
};
///deliverydetialsOfBuyer
exports.deliverydetialsOfBuyer = (req, res) => {
  const { userId } = req.query;
 

  userRepository.deliverydetialsOfBuyer(userId)
      .then((result) => {
          console.log({result});
      
          res.status(200).json(result);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
};

//ibtisam 


exports.getdatauser = (req, res) => {
  userRepository
    .getdatauser(req, res)
    .then((message) => {
      res.status(201).json({ message }); // Registration was successful, return the success message
    })
    .catch((error) => {
      res.status(400).json({ message: error }); // Registration encountered an error, return the error message
    });
};

exports.updateadminofuser = (req, res) => {


  userRepository.updateadminofuser(req, res);

};

// ibtisam end 

exports.adduserfromadmin = (req, res) => {
  userRepository
    .adduserfromadmin(req, res)
    .then((message) => {
      res.status(201).json({ message }); 
    })
    .catch((error) => {
      res.status(400).json({ message: error }); // Registration encountered an error, return the error message
    });
};

