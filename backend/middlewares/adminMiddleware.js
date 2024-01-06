const jwt = require("jsonwebtoken");
const UserModel = require("../models/userModel");

const adminMiddleware = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({
        message: "No auth token. access denied.",
      });

    const isValid = jwt.verify(token, "passwordKey");
    if (!isValid)
      return res.status(401).json({
        message: "Invalid token, acess denied.",
      });

    const user = await UserModel.findById(isValid.id);

    if (user.role != "admin")
      return res.status(401).json({
        message: "You are not an authorized admin.",
      });

    req.user = isValid.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = adminMiddleware;
