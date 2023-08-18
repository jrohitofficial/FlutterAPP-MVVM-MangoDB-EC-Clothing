const Order = require("../models/OrderModel");
const ErrorHandler = require("../utils/ErrorHandler.js");
const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const Product = require("../models/productModel.js");
const OrderHistory = require("../models/Orders");
const Orders = require("../models/Orders");
const neworderModel = require("../models/newOrderModel");
const CartModal = require("../models/cartModel.js");

//create new order:
exports.createNewOrder = catchAsyncErrors(async (req, res, next) => {
  try {
    const { cartItems, totalAmount, paymentType } = req.body;
    console.log(req.body);
    const newOrder = new neworderModel({
      cartItems: cartItems,
      totalAmount: totalAmount,
      user: req.user.id,
      paymentType: paymentType,
    });
    const savedOrder = await newOrder.save();
    console.log("Order created:", savedOrder);

    // Remove the cartModel of the user
    await CartModal.deleteMany({ user: req.user.id });

    res.status(200).json(savedOrder);
  } catch (error) {
    console.error("Error creating order:", error);
    res.status(500).json({ error: "Failed to create order" });
  }
});

// get all orders of user

exports.usergetAllOrders = catchAsyncErrors(async (req, res, next) => {
  try {
    const orders = await neworderModel.find({ user: req.user.id });
    console.log(orders);
    res.status(200).json(orders);
  } catch (error) {
    console.error("Error getting orders:", error);
    res.status(500).json({ error: "Failed to get orders" });
  }
});

// create Order
// exports.createOrder = catchAsyncErrors(async (req, res, next) => {
//   const {
//     shippingInfo,
//     orderItems,
//     paymentInfo,
//     itemsPrice,
//     taxPrice,
//     shippingPrice,
//     totalPrice,
//   } = req.body;

//   const order = await Order.create({
//     shippingInfo,
//     orderItems,
//     paymentInfo,
//     itemsPrice,
//     taxPrice,
//     shippingPrice,
//     totalPrice,
//     paidAt: Date.now(),
//     user: req.user._id,
//   });

//   res.status(201).json({
//     success: true,
//     order,
//   });
// });

// ceate order history ---- FFFFFFFFFFF
exports.createOrderHistory = catchAsyncErrors(async (req, res, next) => {
  console.log(req.body);
  try {
    const orderHistory = await OrderHistory.create({
      productName: req.body.ProductName,
      productPrice: req.body.ProductPrice,
      productImage: req.body.ProductImage,
      paymentType: req.body.PaymentType,
      address: req.body.Address,
      email: req.body.Email,
      range: req.body.Range,
      user: req.user.id,
    });

    console.log(orderHistory);
    res.status(200).json({
      success: true,
      orderHistory,
    });
  } catch (error) {
    console.log(error);
  }
});

// get order history according to email
exports.getOrderHistory = catchAsyncErrors(async (req, res, next) => {
  console.log("hottttttttttttttttttt");
  // console.log("req.params.id");
  // console.log(req.params.id);
  const orderHistory = await OrderHistory.find({ user: req.user.id });
  console.log(orderHistory);
  if (!orderHistory) {
    return next(new ErrorHandler("Items Ordered not found from this id", 404));
  }
  res.status(200).json(orderHistory);
});

// --------------------------------fff

// get single order
exports.getSingleOrder = catchAsyncErrors(async (req, res, next) => {
  const order = await Order.findById(req.params.id).populate(
    "user",
    "name email"
  );

  if (!order) {
    return next(new ErrorHandler("Items Ordered not found from this id", 404));
  }

  res.status(200).json({
    success: true,
    order,
  });
});

// get all orders
exports.getAllOrders = catchAsyncErrors(async (req, res, next) => {
  const orders = await Order.find({ user: req.user._id });

  res.status(200).json({
    success: true,
    orders,
  });
});

// get all orders =======admin only
exports.getAllOrdersAdmin = catchAsyncErrors(async (req, res, next) => {
  const orders = await Orders.find();

  res.status(200).json({
    success: true,
    orders,
  });
});

// admin update order status and update status
exports.updateOrderStatusAdmin = catchAsyncErrors(async (req, res, next) => {
  const { status, updateStatus } = req.body;
  console.log(req.body);
  console.log(req.params.id);

  const orderUpdate = await Orders.findByIdAndUpdate(
    req.params.id,
    {
      status,
      updateStatus,
    },
    {
      new: true,
      validateBeforeSave: false,
      useFindAndModify: false,
    }
  );

  res.status(200).json({
    success: true,
    message: "Order Status Updated",
    orderUpdate,
    status,
  });
});

//update order status === admin
exports.updateOrderAdmin = catchAsyncErrors(async (req, res, next) => {
  const order = await Order.findById(req.params.id);

  if (!order) {
    return next(new ErrorHandler("Order did not find with this Id", 404));
  }

  if (order.orderStatus === "Delivered") {
    return next(new ErrorHandler("Order is already delivered", 400));
  }

  if (req.body.status === "Shipped") {
    order.orderItems.forEach(async (o) => {
      await updateStock(o.product, o.quantity);
    });
  }
  order.orderStatus = req.body.status;

  if (req.body.status === "Delivered") {
    order.deliveredAt = Date.now();
  }

  await order.save({ validateBeforeSave: false });
  res.status(200).json({
    success: true,
  });
});

async function updateStock(id, quantity) {
  const product = await Product.findById(id);

  product.stock -= quantity;

  await product.save({ validateBeforeSave: false });
}

// delete order
exports.deleteOrderAdmin = catchAsyncErrors(async (req, res, next) => {
  const order = await Order.findById(req.params.id);

  if (!order) {
    return next(new ErrorHandler("Order did not find with this id", 404));
  }

  await order.remove();

  res.status(200).json({
    success: true,
  });
});
