import 'package:flutter_library_managent/core/failure/failure.dart';
import 'package:flutter_library_managent/features/Home/data/model/products.dart';

class BookState {
  bool isLoading;
  List<Product> books;
  AppException failure;

  BookState({
    this.isLoading = false,
    this.books = const [],
    required this.failure,
  });

  BookState copyWith({
    bool? isLoading,
    List<Product>? books,
    AppException? failure,
  }) {
    return BookState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      failure: failure ?? this.failure,
    );
  }
}
