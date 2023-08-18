const mongoose = require("mongoose");
const { stringify } = require("nodemon/lib/utils");
const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "Please enter name of your Book name"],
    trim: true,
    // maxlength: [20, "Procustname cannot exceed 20 characters"],
  },
  description: {
    type: String,
    required: [true, "Please add description of your Book"],
    // maxlength: [4000, "Despcription cannot exceed than 4000 characters"],
  },
  price: {
    type: Number,
    required: [true, "Add price of product"],
    maxlength: [8, "price cant exceed 8 characters"],
  },
  offerPrice: {
    type: String,
    // maxlength: [4, "Discount price can't be more"],
  },
  color: {
    type: String,
  },
  size: {
    type: String,
  },
  ratings: {
    type: Number,
    default: 0,
  },
  images: [
    {
      public_id: {
        type: String,
        required: true,
      },
      url: {
        type: String,
        required: true,
      },
    },
  ],
  category: {
    type: String,
    required: [true, "Please add category of book"],
  },
  stock: {
    type: Number,
    required: [true, "Plz add some stock for book"],
    maxlength: [3, "Stock  can't be more than 3"],
  },
  NoOfReviews: {
    type: Number,
    default: 0,
  },
  reviews: [
    {
      user: {
        type: mongoose.Schema.ObjectId,
        ref: "User",
        required: "true",
      },
      name: {
        type: String,
        required: true,
      },
      rating: {
        type: Number,
        required: true,
      },
      comment: {
        type: String,
      },
      time: {
        type: Date,
        default: Date.now(),
      },
    },
  ],
  user: {
    type: mongoose.Schema.ObjectId,
    ref: "User",
  },
  createdAt: {
    type: Date,
    default: Date.now(),
  },
});

module.exports = mongoose.model("Product", productSchema);
