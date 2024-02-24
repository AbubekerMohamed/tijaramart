// import from packages
const express = require("express");
const jwt = require("jsonwebtoken");

// import from files
const adminMiddleware = require("../middlewares/adminMiddleware");
const { ProductModel } = require("../models/productModel");
const OrderModel = require("../models/orderModel");

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
adminRouter.get("/admin/get-products", adminMiddleware, async (req, res) => {
  try {
    const products = await ProductModel.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// delete product route
adminRouter.post("/admin/delete-product", adminMiddleware, async (req, res) => {
  try {
    const { id } = req.body;
    let updatedProducts = await ProductModel.findByIdAndDelete(id);
    res.json(updatedProducts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// add product route
adminRouter.get("/admin/get-orders", adminMiddleware, async (req, res) => {
  try {
    const orders = await OrderModel.find({});
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// update order status route
adminRouter.post(
  "/admin/update-order-status",
  adminMiddleware,
  async (req, res) => {
    try {
      const { id, status } = req.body;
      let updatedOrder = await OrderModel.findById(id);
      if (status == 1) {
        updatedOrder.status = updatedOrder.status + 1;
      } else {
        updatedOrder.status = updatedOrder.status - 1;
      }
      updatedOrder = await updatedOrder.save();
      res.json(updatedOrder);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
);

// get total earnings analysis
adminRouter.get("/admin/analytics", adminMiddleware, async (req, res) => {
  try {
    const orders = await OrderModel.find({});
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // fetch by category
    const mobileEarnings = await fetchTotalEarningsByCategory("Mobiles");
    const essentialEarnings = await fetchTotalEarningsByCategory("Essentials");
    const applianceEarnings = await fetchTotalEarningsByCategory("Appliances");
    const bookEarnings = await fetchTotalEarningsByCategory("Books");
    const fashionEarnings = await fetchTotalEarningsByCategory("Fashions");

    const earnings = {
      totalEarnings,
      mobileEarnings,
      essentialEarnings,
      applianceEarnings,
      bookEarnings,
      fashionEarnings,
    };

    res.json(earnings);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

async function fetchTotalEarningsByCategory(category) {
  let earnings = 0;
  let ordersInCategory = OrderModel.find({
    "products.product.category": category,
  });
  for (let i = 0; i < ordersInCategory.length; i++) {
    for (let j = 0; j < ordersInCategory[i].products.length; j++) {
      earnings +=
        ordersInCategory[i].products[j].quantity *
        ordersInCategory[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;
