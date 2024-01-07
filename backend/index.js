// import from packages
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

// imports from files
const authRouter = require("./routes/authRouter");
const adminRouter = require("./routes/adminRouter");
const productRouter = require("./routes/productRouter");
// instances
const PORT = 3000;
const DB_URL =
  "mongodb+srv://abumoha1892:xgN0laIm6r64YLMu@cluster0.d773zb8.mongodb.net/?retryWrites=true&w=majority";
const app = express();

// configure middlewares
app.use(cors());
app.use(express.json()); // for serialization
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

// establish connections
mongoose
  .connect(DB_URL)
  .then(() => {
    console.log(`Mongoose connected successfully.`);
  })
  .catch(() => {
    console.log(`Mongoose connection failed.`);
  });

// API calls starts here
app.get("/", (req, res) => {});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Backend has started on port  ${PORT}`);
});
