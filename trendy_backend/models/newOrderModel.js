const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema({
  productName: String,
  productPrice: Number,
  producQuantity: Number,
});

const orderSchema = new mongoose.Schema({
  cartItems: [cartSchema],
  totalAmount: Number,
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  paymentType : String
});

const Order = mongoose.model("Orders", orderSchema);

module.exports = Order;
