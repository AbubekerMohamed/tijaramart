// import from packages
const express = require("express");
const jwt = require("jsonwebtoken");

// import from files
const UserModel = require("../models/userModel");
const adminMiddleware = require("../middlewares/adminMiddleware");

const adminRouter = express.Router();

// add product route
adminRouter.post("/admin/add-product", admin, async (req, res){
  try {
    const { name, description, price, quantity, category,images,} = req.body;
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

module.exports = authRouter;
