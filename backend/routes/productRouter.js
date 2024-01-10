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

// search product route
productRouter.get("/api/products/search:query", auth, async (req, res) => {
  try {
    const searchQuery = req.params["query"];
    const products = await ProductModel.find({
      name: { $regex: searchQuery, $options: "i" },
    });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// rate product route
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await ProductModel.findById(id);

    for (let index = 0; index < product.rating.length; index++) {
      if (product.rating[index].userId == req.user) {
        product.rating.splice(index, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.rating.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.get("/api/deal-of-the-day", auth, async (req, res) => {
  try {
    let products = await ProductModel.find({});
    products.sort((productA, productB) => {
      let aTotalRatings = 0;
      let bTotalRatings = 0;
      for (let index = 0; index < productA.rating.length; index++) {
        aTotalRatings += productA.rating[index].rating;
      }
      for (let index = 0; index < productB.rating.length; index++) {
        bTotalRatings += productB.rating[index].rating;
      }

      return aTotalRatings < bTotalRatings ? 1 : -1;
    });

    res.json(products[0]);
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
});

module.exports = productRouter;
