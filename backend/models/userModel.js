const mongoose = require("mongoose");
const { productSchema } = require("./productModel");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const emailRegex =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(emailRegex);
      },
      message: "please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
    validate: {
      validator: (value) => {
        const passwordRegex = `(?=^.{7,}$)(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[^A-Za-z0-9]).*`;
        return value.match(passwordRegex);
      },
      message:
        "A password must be more than 6 characters and contain a digit, an uppercase, a lowercase and a special symbol.",
    },
  },
  address: {
    type: String,
    default: "",
  },
  role: {
    type: String,
    default: "customer",
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const UserModel = mongoose.model("User", userSchema);
module.exports = UserModel;
