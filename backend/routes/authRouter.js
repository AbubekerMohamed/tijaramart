// import from packages
const express = require("express");
const bcryptjs = require("bcryptjs");

// import from files
const UserModel = require("../models/userModel");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    // get the provided info
    const { name, email, password } = req.body;

    // check if email exists
    const userExists = await UserModel.findOne({ email });
    if (userExists) {
      return res.status(400).json({
        msg: "The email address already is registered with other account.",
      });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    // prepare the js object to database model
    let user = new UserModel({
      name,
      email,
      password: hashedPassword,
    });
    // save to mongodb
    user = await user.save();

    // return sucess or error
    res.json(user);
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
});

module.exports = authRouter;
