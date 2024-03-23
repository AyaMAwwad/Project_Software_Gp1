const bcrypt = require('bcrypt');
const catchAsync = require('../utils/catchAsync');
const { sequelize } = require('../models/Sequelize');
class AuthController {
static signup = catchAsync(async (req, res, next) => {
  const newUser = {
    first_name: req.body.first_name,
    last_name: req.body.last_name,
    email: req.body.email,
    password: req.body.password,
    address: req.body.address,
    birthday: req.body.birthday,
    phone_number: req.body.phone_number,
  };

  // Check if the username or email already exists
  const existingUser = await sequelize.query(
    'SELECT * FROM user WHERE email = :email',
    {
      replacements: {
       
        email: newUser.email,
      },
      type: sequelize.QueryTypes.SELECT,
    },
  );

  if (existingUser.length > 0) {
    return res.status(409).json({
      status: 'error',
      message: 'Username or email already exists.',
    });
  }

  bcrypt.hash(newUser.password, 10, async (hashError, hashedPassword) => {
    if (hashError) {
      console.error('Error hashing the password:', hashError);
      return res.status(500).json({
        status: 'error',
        message: 'Error hashing the password',
      });
    }
   

    newUser.password = hashedPassword;
    const date=new Date(newUser.birthday);
    try {
      await sequelize.query(
        'INSERT INTO User (first_name, last_name, email, password, address, birthday, phone_number) VALUES (:first_name, :last_name, :email, :password, :address, :birthday, :phone_number)',
        {
          replacements: {
            first_name: newUser.first_name,
            last_name: newUser.last_name,
            email: newUser.email,
            password: newUser.password,
            address: newUser.address,
            birthday: date,
            phone_number: newUser.phone_number,
          },
          type: sequelize.QueryTypes.INSERT,
        },
      );
      

      res.status(201).json({
        status: 'success ',
        message: 'User created successfully.',
      });
    } catch (insertError) {
      console.error('Error inserting into the database:', insertError);
      res.status(500).json({
        status: 'error',
        message: 'Error inserting into the database',
      });
    }
  });
});
}

module.exports = AuthController;
