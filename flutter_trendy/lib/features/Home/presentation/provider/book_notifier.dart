import 'package:flutter_library_managent/features/Home/data/repository/productRepository.dart';
import 'package:flutter_library_managent/features/Home/data/response/productResponse.dart';
import 'package:flutter_library_managent/features/Home/presentation/provider/book_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/products.dart';

final bookStateNotifierProvider =
    StateNotifierProvider<BookStateNotifier, BookState>((ref) {
  final bookRemoteRepository = ref.watch(productRemoteRepositoryProvider);
  return BookStateNotifier(bookRemoteRepository);
});

class BookStateNotifier extends StateNotifier<BookState> {
  final BookRemoteRepository _bookRemoteRepository;

  BookStateNotifier(this._bookRemoteRepository)
      : super(BookState(
            isLoading: false, books: [], failure: AppException(error: ''))) {
    getBooks('');
  }

  Future<void> getBooks(String keyword) async {
    state = state.copyWith(isLoading: true, failure: AppException(error: ''));

    final result = await _bookRemoteRepository.getBooks(keyword);

    result.fold(
      (AppException failure) {
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (ProductResponse books) {
        state = state.copyWith(
          isLoading: false,
          books: books as List<Product>,
          failure: AppException(error: ''),
        );

        for (var book in state.books) {
          print(book.category);
        }
      },
    );
  }
}
