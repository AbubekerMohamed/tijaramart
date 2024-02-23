// import from packages
const express = require("express");

// import from files
const auth = require("../middlewares/authMiddleware");
const { ProductModel } = require("../models/productModel");
const UserModel = require("../models/userModel");
const OrderModel = require("../models/orderModel");

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
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// remove product from cart
userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await ProductModel.findById(id);
    let user = await UserModel.findById(req.user);

    for (let index = 0; index < user.cart.length; index++) {
      if (user.cart[index].product._id.equals(product._id)) {
        if (user.cart[index].quantity == 1) {
          user.cart.splice(index, 1);
        } else {
          user.cart[index].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// save users address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;

    let user = await UserModel.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// order a product
userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];
    for (let i = 0; i < cart.length; i++) {
      let product = await ProductModel.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res
          .status(400)
          .json({ msg: `${product.name} is out of stock.` });
      }
    }

    let user = await UserModel.findById(req.user);
    user.cart = [];
    user = await user.save();
    let order = new OrderModel({
      products,
      totalPrice,
      address,
      userID: req.user,
      orderedAt: new Date.getTime(),
    });
    order = await order.save();

    res.json(order);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
