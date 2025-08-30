const express = require("express");

const userController = require("../controller/userController");

const auth = require("../middlewares/auth");
const { verify } = require("jsonwebtoken");
const route = express.Router();

route.get("/", userController.signUp);

route.post("/createUser", userController.createUser);

route.get("/login", userController.getLoginPage);

route.post("/loginData", userController.loginData);

route.get("/home", auth.verifyToken, userController.home);

route.get(
  "/product/:category",
  auth.verifyToken,
  userController.displayProducts
);

route.get("/buy/:id", auth.verifyToken, userController.addToCartById);

route.get("/view/:id", auth.verifyToken, userController.viewDetailsById);

route.get("/cart", auth.verifyToken, userController.displayCart);

route.post("/update-cart/:id", auth.verifyToken, userController.updateCart);

route.get("/delete_cart/:id", auth.verifyToken, userController.deleteCartRow);

route.post("/place_order", auth.verifyToken, userController.placeOrder);

route.get("/logout", auth.verifyToken, userController.logout);

module.exports = route;
