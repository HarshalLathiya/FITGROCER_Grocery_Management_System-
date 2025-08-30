const jwt = require("jsonwebtoken");

exports.verifyToken = (req, res, next) => {
  const token = req.cookies.token;

  if (!token) {
    return res.status(401).send("Access Denied. No token provided.");
  }

  try {
    const decoded = jwt.verify(token, process.env.SECRATE_KEY); // Verify token

    req.user = decoded; // Attach decoded user data to request object

    next(); // Proceed to the next middleware or route
  } catch (err) {
    return res.status(403).send("Invalid Token");
  }
};
