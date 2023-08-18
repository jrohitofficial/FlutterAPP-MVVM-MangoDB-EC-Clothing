const app = require("./app");
const dotenv = require("dotenv");
const connectDatabase = require("./db/Database");
const cloudinary = require("cloudinary");

// handling uncought exception
process.on("uncaughtException", (err) => {
    console.log("Error Uncaught Exception Occured: ", err.message);
    console.log("server shut down for Uncaught Exception Occured");
});

//config
dotenv.config({
    path: "./config/.env",
});

// connect database
connectDatabase();

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
});

//create server
const server = app.listen(process.env.PORT, () => {
    console.log(`Server is working on http://localhost:${process.env.PORT}`);
});

// unhandled promise rejections
process.on("unhandledRejection", (err, promise) => {
    console.log(`Error of server down: ${err.message}`);
    console.log(`Error of server down due to unhandled promise rejections`);
    // close server & exit process
    server.close(() => process.exit(1));
});

module.exports = server;