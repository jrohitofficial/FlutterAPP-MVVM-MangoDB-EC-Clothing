// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_and_api_for_class/config/constants/hive_table_constant.dart';
// import 'package:hive_and_api_for_class/features/auth/data/model/auth_hive_model.dart';
// import 'package:hive_and_api_for_class/features/batch/data/model/batch_hive_model.dart';
// import 'package:hive_and_api_for_class/features/course/data/model/course_hive_model.dart';
// import 'package:path_provider/path_provider.dart';

// final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

// class HiveService {
//   Future<void> init() async {
//     var directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);

//     // Register Adapters
//     Hive.registerAdapter(AuthHiveModelAdapter());
//     Hive.registerAdapter(BatchHiveModelAdapter());
//     Hive.registerAdapter(CourseHiveModelAdapter());

//     // Add dummy data
//     await addDummybatch();
//     await addDummyCourse();
//   }

//   // ======================== Batch Queries ========================
//   Future<void> addBatch(BatchHiveModel batch) async {
//     var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
//     await box.put(batch.batchId, batch);
//   }

//   Future<List<BatchHiveModel>> getAllBatches() async {
//     var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
//     var batches = box.values.toList();
//     box.close();
//     return batches;
//   }

//   // ======================== Course Queries ========================
//   Future<void> addCourse(CourseHiveModel course) async {
//     var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
//     await box.put(course.courseId, course);
//   }

//   Future<List<CourseHiveModel>> getAllCourses() async {
//     var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
//     var courses = box.values.toList();
//     box.close();
//     return courses;
//   }

//   // ======================== Student Queries ========================
//   Future<void> addStudent(AuthHiveModel student) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//     await box.put(student.studentId, student);
//   }

//   Future<List<AuthHiveModel>> getAllStudents() async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//     var students = box.values.toList();
//     box.close();
//     return students;
//   }

//   //Login
//   Future<AuthHiveModel?> login(String username, String password) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//     var student = box.values.firstWhere((element) =>
//         element.username == username && element.password == password);
//     box.close();
//     return student;
//   }

//   // ======================== Insert Dummy Data ========================
//   // Batch Dummy Data
//   Future<void> addDummybatch() async {
//     // check of batch box is empty
//     var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
//     if (box.isEmpty) {
//       final batch1 = BatchHiveModel(batchName: '29-A');
//       final batch2 = BatchHiveModel(batchName: '29-B');
//       final batch3 = BatchHiveModel(batchName: '30-A');
//       final batch4 = BatchHiveModel(batchName: '30-B');

//       List<BatchHiveModel> batches = [batch1, batch2, batch3, batch4];

//       // Insert batch with key
//       for (var batch in batches) {
//         await addBatch(batch);
//       }
//     }
//   }

//   Future<void> addDummyCourse() async {
//     // check of course box is empty
//     var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
//     if (box.isEmpty) {
//       final course1 = CourseHiveModel(courseName: 'Flutter');
//       final course2 = CourseHiveModel(courseName: 'Dart');
//       final course3 = CourseHiveModel(courseName: 'Java');
//       final course4 = CourseHiveModel(courseName: 'Kotlin');

//       List<CourseHiveModel> courses = [course1, course2, course3, course4];

//       // Insert course with key
//       for (var course in courses) {
//         await addCourse(course);
//       }
//     }
//   }

//   // ======================== Delete All Data ========================
//   Future<void> deleteAllData() async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
//     await box.clear();
//   }

//   // ======================== Close Hive ========================
//   Future<void> closeHive() async {
//     await Hive.close();
//   }

//   // ======================== Delete Hive ========================
//   Future<void> deleteHive() async {
//     var directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);
//     await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
//     await Hive.deleteBoxFromDisk(HiveTableConstant.batchBox);
//     await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
//     await Hive.deleteFromDisk();
//   }
// }
