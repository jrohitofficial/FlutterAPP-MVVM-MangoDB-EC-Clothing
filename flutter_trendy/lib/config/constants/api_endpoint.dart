class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:4000/api/v2";  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "/login";
  static const String register = "/register";
  static const String profile = '/userdetails';
  static const String updateProfile = '/me/update/profiles';
  static const String chnagePassword = "/me/updates";
  static const String getusercart = '/getcart';
  static const String createOrder = '/order/create';
  static const String getOrders = '/order/getall';
  //==================End auth routes =================

  // ====================== get all books ======================
  static const String getBooks = "/products";
  static const String getAllStudent = "auth/getAllStudents";
  static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ====================== Batch Routes ======================
  static const String createBatch = "batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";

  // ====================== Course Routes ======================
  static const String createCourse = "course/createCourse";
  static const String deleteCourse = "course/";
  static const String getAllCourse = "course/getAllCourse";

  // ====================== cart roue ======================
  static const String addToCart = "/addtocart";
  static const String getCart = "/getcart";
}
