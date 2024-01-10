// import from packages
const express = require("express");

// import from files
const auth = require("../middlewares/authMiddleware");
const { ProductModel } = require("../models/productModel");
const UserModel = require("../models/userModel");

const userRouter = express.Router();

// add product to cart
userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await ProductModel.findById(id);
    let user = await UserModel.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductAdded = false;
      for (let index = 0; index < user.cart.length; index++) {
        if (user.cart[index].product._id.equals(id)) {
          isProductAdded = true;
        }
      }
      if (isProductAdded) {
        let existingProduct = user.cart.find((aProduct) =>
          aProduct.product._id.equals(product._id)
        );
        existingProduct.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }

    user = await user.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
