const db = require("../utils/db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

exports.dashboard = (req, res) => {
  res.render("dashboard");
};

exports.addProductForm = (req, res) => {
  res.render("addProduct");
};

exports.addNewProduct = async (req, res) => {
  try {
    const query = `insert into products (name,description,price,type,quantity,image_name) values ("${req.body.name}","${req.body.description}","${req.body.price}","${req.body.type}","${req.body.quantity}","${req.body.file1}")`;
    await db.execute(query);
    res.render("dashboard");
  } catch (err) {
    console.log(err);
  }
};

exports.viewProduct = async (req, res) => {
  try {
    const query = `select * from products`;
    const [result] = await db.execute(query);
    res.render("viewProduct", { data: result });
  } catch (err) {
    console.log(err);
  }
};

exports.deleteProductByID = async (req, res) => {
  try {
    const query = `delete from products where id=${req.params.id}`;
    await db.execute(query);

    const query2 = `select * from products`;
    const [result2] = await db.execute(query2);
    res.render("viewProduct", { data: result2 });
  } catch (err) {
    console.log(err);
  }
};

exports.EditProduct = async (req, res) => {
  const id = req.params.id;
  res.render("editProduct", { id });
};

exports.EditProductByID = async (req, res) => {
  try {
    const query = `UPDATE products SET name = "${req.body.name}", description ="${req.body.description}", price = "${req.body.price}",type = "${req.body.type}", quantity = "${req.body.quantity}", image_name = "${req.body.file1}" WHERE id = "${req.params.id}"`;
    await db.execute(query);
    console.log(query);

    const query2 = `select * from products`;
    const [result2] = await db.execute(query2);
    res.render("viewProduct", { data: result2 });
  } catch (err) {
    console.log(err);
  }
};

exports.viewOrder = async (req, res) => {
  const query2 = `select o.product_id , o.quantity , o.user_id , o.shipping_address , o.total_amount , o.orderDateTime , p.name , p.image_name  from \`order\` as o JOIN products as p ON o.product_id = p.id`;
  const [result] = await db.execute(query2);

  res.render("viewOrder", { data: result });
};

exports.nutritionPage = async (req, res) => {
  try {
    const query = `select name from products`;
    const [result] = await db.execute(query);

    res.render("formNutrients", { data: result });
  } catch (err) {
    console.log(err);
  }
};

exports.addNutrients = async (req, res) => {
  try {
    // console.log(`${req.body.product}`);

    const query = `select * from products where name="${req.body.product}"`;
    const [result] = await db.execute(query);
    // console.log(result);

    const productId = result[0].id;

    const values = [
      productId,
      req.body.vitamins,
      req.body.carbohydrates,
      req.body.fiber,
      req.body.protien,
      req.body.fat,
      req.body.calories,
    ];

    const query2 = `INSERT INTO nutritions (product_id, vitamins, carbohydrates, fiber, protien, fat, calories) VALUES (?, ?, ?, ?, ?, ?, ?)`;
    const [result2] = await db.execute(query2, values);
    // console.log(result2);

    res.render("dashboard");
  } catch (err) {
    console.log(err);
  }
};

exports.viewNutritions = async (req, res) => {
  try {
    const query = `select p.name , p.image_name , n.vitamins , n.carbohydrates , n.fiber , n.protien , n.fat , n.calories , n.product_id from products as p JOIN nutritions as n on p.id = n.product_id `;
    const [result] = await db.execute(query);
    // console.log(result);

    res.render("viewNutritions", { data: result });
  } catch (err) {
    console.log(err);
  }
};

exports.deleteNutritionByID = async (req, res) => {
  try {
    const query = `delete from nutritions where product_id=${req.params.product_id}`;
    await db.execute(query);

    const query2 = `select p.name , p.image_name , n.vitamins , n.carbohydrates , n.fiber , n.protien , n.fat , n.calories ,n.product_id from products as p JOIN nutritions as n on p.id = n.product_id `;
    const [result2] = await db.execute(query2);
    res.render("viewNutritions", { data: result2 });
  } catch (err) {
    console.log(err);
  }
};
