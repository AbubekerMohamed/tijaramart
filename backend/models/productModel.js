const mongoose = require("mongoose");

const productSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  description: {
    required: true,
    type: String,
    trim: true,
  },
  images: [{ type: String, required: true }],
  quantity: {
    required: true,
    type: Number,
  },
  price: {
    required: true,
    type: Number,
  },
  category: {
    required: true,
    type: String,
    trim: true,
  },
  //ratings will be added
});

const ProductModel = mongoose.model("Product", productSchema);
module.exports = ProductModel;