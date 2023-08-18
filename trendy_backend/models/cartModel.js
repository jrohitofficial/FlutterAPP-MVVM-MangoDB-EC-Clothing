const mongoose = require("mongoose");


const CartSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.ObjectId,
        ref: "User",
        required: true,
    },
    cartItems: [
        {
            productName: {
                type: String,
            },
            productPrice:{
                type: Number,
            },
            producQuantity:{
                type: Number,
                default: 1,
            } ,
        },
    ],
}, { timestamps: true });

module.exports = mongoose.model("Cart", CartSchema);
