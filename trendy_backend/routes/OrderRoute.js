const express = require("express");
const {
  // createOrder,
  getSingleOrder,
  getAllOrders,
  getAllOrdersAdmin,
  updateOrderAdmin,
  updateOrderStatusAdmin,
  deleteOrderAdmin,
  createOrderHistory,
  getOrderHistory,
  createNewOrder,
  usergetAllOrders,
} = require("../controller/OrderController");
const {
  isAuthenticatedUser,
  authorizedRoles,
  auth,
} = require("../middleware/auth");
const router = express.Router();

router.route("/order/getall").get(auth, usergetAllOrders);

// router.route("/order/new").post(isAuthenticatedUser, createOrder);
router.route("/order/:id").get(isAuthenticatedUser, getSingleOrder);
router.route("/orders/me").get(isAuthenticatedUser, getAllOrders);
router
  .route("/admin/orders")
  .get(isAuthenticatedUser, authorizedRoles("admin"), getAllOrdersAdmin);
router
  .route("/admin/order/:id")
  .put(isAuthenticatedUser, authorizedRoles("admin"), updateOrderAdmin);

router
  .route("/admin/order/:id")
  .delete(isAuthenticatedUser, authorizedRoles("admin"), deleteOrderAdmin);

router
  .route("/admin/order/status/:id")
  .put(isAuthenticatedUser, authorizedRoles("admin"), updateOrderStatusAdmin);

// ==========================================================------

router.route("/order/create").post(auth, createNewOrder);

router.route("/getall/booking").get(auth, getOrderHistory);

router.route("/order/flutter/create").post(auth, createOrderHistory);

router.route("/order/react/create").post(createOrderHistory);

// router.route("/order/react/").get(auth, getOrderHistory);
module.exports = router;
// ======================================--------------------------
