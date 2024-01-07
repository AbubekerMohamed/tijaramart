// import from packages
const express = require("express");

// import from files
const auth = require("../middlewares/authMiddleware");
const ProductModel = require("../models/productModel");

const productRouter = express.Router();

// add product route
productRouter.get("/api/products-in-category", auth, async (req, res) => {
  try {
    const category = req.query["category"];
    const products = await ProductModel.find({ category: category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = productRouter;
