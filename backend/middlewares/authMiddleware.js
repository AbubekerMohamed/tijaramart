const jwt = require("jsonwebtoken");

const authMiddleware = async (req, res, next) => {
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

    req.user = isValid.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = authMiddleware;
