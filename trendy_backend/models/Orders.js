const mongoose = require("mongoose");

const BookOrderIssue = new mongoose.Schema({
  user: {
    type: mongoose.Schema.ObjectId,
    ref: "User",
  },

  productName: {
    type: String,
  },
  productImage: {
    type: String,
  },
  productPrice: {
    type: Number,
  },
  paymentType: {
    type: String,
  },
  address: {
    type: String,
  },
  email: {
    type: String,
  },
  range: {
    type: String,
  },
  updateStatus: {
    type: String,
  },
  status: {
    type: String,
  },
});
module.exports = mongoose.model("BookOrderIssue", BookOrderIssue);
