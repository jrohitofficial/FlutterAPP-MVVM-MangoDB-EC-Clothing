// ignore_for_file: unused_result

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library_managent/features/Home/data/model/products.dart';
import 'package:flutter_library_managent/features/Home/data/repository/productRepository.dart';
import 'package:flutter_library_managent/features/Home/data/response/productResponse.dart';
import 'package:flutter_library_managent/features/Home/presentation/widget/productcard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import 'productdetails.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final List<Product> books = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trendy Wears",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search any clothing item',
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.refresh(productRemoteRepositoryProvider);
                  },
                ),
              ),
              onChanged: (value) {
                ref.refresh(
                    productRemoteRepositoryProvider); // Refresh the provider when search value changes
              },
            ),
          ),
          Expanded(
            child: _buildBookList(
              context,
              ref,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(BuildContext context, WidgetRef ref) {
    final String searchValue = _searchController.text.trim();
    final Future<Either<AppException, ProductResponse>> books =
        searchValue.isNotEmpty
            ? ref.watch(productRemoteRepositoryProvider).getBooks(searchValue)
            : ref.watch(productRemoteRepositoryProvider).getBooks(
                  searchValue,
                ); // Fetch all values if search value is empty

    return FutureBuilder<Either<AppException, ProductResponse>>(
      future: books,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final List<Product> categoryBooks = snapshot.data!.fold(
            (l) => [],
            (r) => r.products as List<Product>,
          );

          return GridView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: categoryBooks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                productName: categoryBooks[index].name.toString(),
                productPrice: categoryBooks[index].price.toString(),
                productImagePath:
                    categoryBooks[index].images![0].url.toString(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        imageUrl:
                            categoryBooks[index].images![0].url.toString(),
                        name: categoryBooks[index].name.toString(),
                        price: categoryBooks[index].price!.toDouble(),
                        description:
                            categoryBooks[index].description.toString(),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Text('No item found.');
        }
      },
    );
  }
}
