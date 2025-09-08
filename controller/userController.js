const db = require("../utils/db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

exports.signUp = (req, res) => {
  res.render("register");
};

exports.createUser = async (req, res) => {
  const hashPassword = await bcrypt.hash(req.body.password, 10);

  try {
    const query = `insert into user (name , phone_number , email , password ) values
    ('${req.body.name}' , '${req.body.phone}','${req.body.email}' , '${hashPassword}');`;
    const [result] = await db.execute(query);
    console.log(result);

    res.render("login");
  } catch (e) {
    console.log("error while inserting user " + e);
  }
};

exports.getLoginPage = (req, res) => {
  res.render("login");
};

exports.loginData = async (req, res) => {
  const password = req.body.password;
  const query1 = `select * from user where email="${req.body.email}"`;
  const [result1] = await db.execute(query1);

  if (result1 != "") {
    const encryptPassword = await bcrypt.compare(password, result1[0].password);

    if (encryptPassword) {
      const data = {
        id: result1[0].id,
        name: result1[0].name,
        phone: result1[0].phone_number,
        email: result1[0].email,
        role: result1[0].role,
      };
      const token = jwt.sign(data, process.env.SECRATE_KEY, {
        expiresIn: "1hr",
      });

      res.cookie("token", token, { httpOnly: true });
      if (data.role == "CUSTOMER") {
        res.render("home");
      } else {
        res.render("dashboard");
      }
    } else {
      res.send("Invalid password");
    }
  } else {
    res.send("Invalid Email");
  }
};
exports.getForgotPasswordPage = (req, res) => {
  res.render("forgot-password");
};

exports.postForgotPassword = async (req, res) => {
  try {
    const { email, newPassword } = req.body;

    const [user] = await db.execute(`SELECT * FROM user WHERE email = ?`, [email]);

    if (user.length === 0) {
      return res.send("No account found with that email.");
    }

    const hashed = await bcrypt.hash(newPassword, 10);

    await db.execute(`UPDATE user SET password = ? WHERE email = ?`, [hashed, email]);

    return res.render("reset_success");
  } catch (err) {
    console.error("Error resetting password:", err);
    res.status(500).send("Server error while resetting password.");
  }
};

exports.getContactPage = (req, res) => {
  res.render("contact");
};

const axios = require("axios");

exports.getContactPage = (req, res) => {
  res.render("contact");
};

exports.postContactForm = async (req, res) => {
  const { name, email, message } = req.body;

  try {
    const response = await axios.post(
      "https://formspree.io/f/xblaqqze",
      {
        name,
        email,
        message
      },
      {
        headers: {
          "Accept": "application/json"
        }
      }
    );

    if (response.status === 200) {
      res.render("contact", {
        successMsg: "Thank you! Your message has been sent✅."
      });
    } else {
      res.render("contact", {
        errorMsg: "Oops! Something went wrong. Please try again❌ ."
      });
    }
  } catch (error) {
    console.error("Formspree error:", error.message);
    res.render("contact", {
      errorMsg: "Could not send your message. Try again later⚠️."
    });
  }
};


exports.home = (req, res) => {
  res.render("home");
};

exports.displayProducts = async (req, res) => {
  try {
    const type = req.params.category;
    // console.log(type);
    const query = `select * from products where type="${type}"`;
    const [result] = await db.execute(query);
    // console.log(result);
    res.render("displayProduct", { data: result, title: type });
  } catch (err) {
    console.log(err);
  }
};

exports.viewDetailsById = async (req, res) => {
  const id = req.params.id;
  // console.log(id);

  const query = `select * from nutritions where product_id=${req.params.id}`;
  const [result] = await db.execute(query);
  // console.log(result);
  const query2 = `select * from products where id=${req.params.id}`;
  const [result2] = await db.execute(query2);
  // console.log(result2);

  res.render("viewDetail", { data: result, pdata: result2 });
};

// Add to Cart

exports.addToCartById = async (req, res) => {
  try {
    const id = req.params.id;
    const userID = req.user.id;

    // console.log(userID);

    const query = `insert into cart (product_id , user_id) values ('${id}','  ${userID}');`;
    await db.execute(query);

    const query2 = `SELECT p.name, p.price,p.quantity AS stock_quantity ,p.image_name, c.quantity, c.id , c.product_id FROM cart AS c JOIN products AS p ON c.product_id = p.id WHERE c.user_id = ?;`;
    const [result2] = await db.execute(query2, [userID]);

    res.render("cart", { data: result2 });
  } catch (err) {
    console.log(err);
  }
};

exports.displayCart = async (req, res) => {
  try {
    const userID = req.user.id;
    const query = `SELECT p.name, p.price,p.quantity AS stock_quantity ,p.image_name, c.quantity, c.id , c.product_id FROM cart AS c JOIN products AS p ON c.product_id = p.id WHERE c.user_id = ?;`;
    const [result] = await db.execute(query, [userID]);
    // console.log(result);
    res.render("cart", { data: result });
  } catch (err) {
    console.log(err);
  }
};

exports.updateCart = async (req, res) => {
  try {
    const quantity = req.body.quantity;
    const query = `UPDATE cart SET quantity = ${quantity} WHERE id = ${req.params.id}`;
    await db.execute(query);

    const userID = req.user.id;
    const query2 = `SELECT p.name, p.price,p.quantity AS stock_quantity, p.image_name , c.quantity, c.id , c.product_id FROM cart AS c JOIN products AS p ON c.product_id = p.id WHERE c.user_id = ?;`;
    const [result] = await db.execute(query2, [userID]);
    // console.log(result);
    res.render("cart", { data: result });
  } catch (err) {
    console.log(err);
  }
};

exports.deleteCartRow = async (req, res) => {
  try {
    const id = req.params.id;
    const query = `delete from cart where id=${id} `;
    await db.execute(query);

    const userID = req.user.id;
    const query2 = `SELECT p.name, p.price , p.image_name, c.quantity, c.id , c.product_id FROM cart AS c JOIN products AS p ON c.product_id = p.id WHERE c.user_id = ?;`;
    const [result] = await db.execute(query2, [userID]);
    // console.log(result);
    res.render("cart", { data: result });
  } catch (err) {
    console.log(err);
  }
};

exports.placeOrder = async (req, res) => {
  try {
    const userID = req.user.id;
    // const totalAmount = req.body.total;
    const query = `insert into user_details (shipping_address,user_id) values ('${req.body.shipping_address}','${userID}')`;
    const result = await db.execute(query);
    // console.log([result][1]);

    const query2 = `SELECT c.product_id, c.quantity, (c.quantity * p.price) AS total, 
                      (SELECT shipping_address FROM user_details WHERE user_id = '${userID}' 
                      ORDER BY id DESC LIMIT 1) AS shipping_address
                      FROM cart AS c 
                      JOIN products AS p ON c.product_id = p.id
                      WHERE c.user_id = '${userID}';`;

    const [result2] = await db.execute(query2);
    // console.log(result2);

    for (let index in result2) {
      let item = result2[index];

      const query3 = `INSERT INTO \`order\` (product_id, user_id, quantity, shipping_address, total_amount) 
                      VALUES ('${item.product_id}', '${req.user.id}', '${item.quantity}', '${item.shipping_address}', '${item.total}')`;

      const [result3] = await db.execute(query3);
      // console.log(result3);

      const query4 = `update products set quantity = quantity-${item.quantity} where id = ${item.product_id} AND quantity >= ${item.quantity}`;
      await db.execute(query4);
    }

    const query5 = `delete from cart where user_id = '${req.user.id}'`;
    await db.execute(query5);

    res.render("place_order");
  } catch (err) {
    console.log(err);
  }
};

exports.logout = (req, res) => {
  res.clearCookie("token");
  res.redirect("/login");
};
