// import from packages
const express = require("express");
const jwt = require("jsonwebtoken");

// import from files
const adminMiddleware = require("../middlewares/adminMiddleware");
const ProductModel = require("../models/productModel");

const adminRouter = express.Router();

// add product route
adminRouter.post("/admin/add-product", adminMiddleware, async (req, res) => {
  try {
    const { name, description, price, quantity, category, images } = req.body;
    let product = new ProductModel({
      name,
      description,
      price,
      quantity,
      category,
      images,
    });

    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// add product route
adminRouter.post("/admin/get-products", adminMiddleware, async (req, res) => {
  try {
    const products = await ProductModel.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = adminRouter;
