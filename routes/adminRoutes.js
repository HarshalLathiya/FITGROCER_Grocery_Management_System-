const express = require("express");
const adminController = require("../controller/adminController");

const auth = require("../middlewares/auth");

const route = express.Router();

route.get("/admin", adminController.dashboard);

route.get(
  "/admin/addProduct",
  auth.verifyToken,
  adminController.addProductForm
);

route.post(
  "/admin/addNewProduct",
  auth.verifyToken,
  adminController.addNewProduct
);

route.get("/admin/viewProduct", auth.verifyToken, adminController.viewProduct);

route.get(
  "/admin/EditProduct/:id",
  auth.verifyToken,
  adminController.EditProduct
);

route.post(
  "/admin/editProductByID/:id",
  auth.verifyToken,
  adminController.EditProductByID
);

route.get(
  "/admin/deleteProduct/:id",
  auth.verifyToken,
  adminController.deleteProductByID
);

route.get("/admin/viewOrders", auth.verifyToken, adminController.viewOrder);

route.get(
  "/admin/addNutrients",
  auth.verifyToken,
  adminController.nutritionPage
);

route.post(
  "/admin/addNutrients",
  auth.verifyToken,
  adminController.addNutrients
);

route.get(
  "/admin/viewNutritions",
  auth.verifyToken,
  adminController.viewNutritions
);

route.get(
  "/admin/deleteNutrition/:product_id",
  auth.verifyToken,
  adminController.deleteNutritionByID
);

module.exports = route;
