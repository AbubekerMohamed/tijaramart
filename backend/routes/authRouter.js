const express = require("express");

const authRouter = express.Router();

authRouter.post("/api/signup", (req, res) => {
  // get the provided info
  const { name, email, password } = req.body;
  // save data to database

  // return sucess or error
});

module.exports = authRouter;
