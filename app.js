const express = require("express");
const bodyParser = require("body-parser");
const path = require("path");
const route = require("./routes/userRoutes");
const adminRoute = require("./routes/adminRoutes");

const cookieParser = require("cookie-parser");

const dotenv = require("dotenv");

const app = express();

app.set("view engine", "ejs");
app.set("views", "views");
app.set("views", path.join(__dirname, "views"));

dotenv.config();
const port = process.env.PORT || 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static("public"));

app.use(route);
app.use(adminRoute);

app.listen(port, () => {
  console.log(`http://localhost:${port}`);
});
