import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library_managent/core/failure/failure.dart';
import 'package:flutter_library_managent/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter_library_managent/features/Home/data/model/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_library_managent/features/Home/data/repository/productRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String imageUrl;
  final String name;
  final double price;
  final String description;

  const ProductDetailsScreen({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  UserSharedPrefs? userSharedPrefs;
  // add to cart
  void _addToCart() async {
    ref
        .read(productRemoteRepositoryProvider)
        .addToCart(
          Cart(
              productPrice: widget.price.toInt(),
              productName: widget.name,
              producQuantity: 1),
        )
        .then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cloths added to cart'),
                  duration: Duration(seconds: 1),
                ),
              )
            });

    // bookRepository.onError((error, stackTrace) => print(error);
    // Perform the necessary logic to add the product to the cart using bookRepository
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloths Details'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \$${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _addToCart();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  primary: Colors.black,
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
