// import from packages
const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

// import from files
const UserModel = require("../models/userModel");

const authRouter = express.Router();

// Sign up route
authRouter.post("/api/signup", async (req, res) => {
  try {
    // get the provided info
    const { name, email, password } = req.body;

    // check if email exists
    const userExists = await UserModel.findOne({ email });
    if (userExists) {
      return res.status(400).json({
        message: "The email address already is registered with other account.",
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

//Sign in route
authRouter.post("/api/signin", async (req, res) => {
  try {
    // get the email and password
    const { email, password } = req.body;

    //check whther the email exists
    const user = await UserModel.findOne({ email });
    // respond with error if email not found
    if (!user) {
      return res.status(400).json({
        message: "No account registered with this email.",
      });
    }
    // check if password matches
    const matchedPassword = await bcryptjs.compare(password, user.password);
    // respond with error if password not matched
    if (!matchedPassword) {
      return res.status(400).json({
        message: "Incorrect password. Please try again.",
      });
    }
    // generatejwt token with the user id
    const token = jwt.sign(
      {
        id: user._id,
      },
      "passwordKey"
    );

    return res.json({
      token,
      ...user._doc,
    });
  } catch (error) {
    res.status(500).json({
      message: error.message,
    });
  }
});

module.exports = authRouter;
