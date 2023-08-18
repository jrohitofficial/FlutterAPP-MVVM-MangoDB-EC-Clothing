import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:light/light.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../core/failure/failure.dart';
import '../data/model/OrderResponse.dart';
import '../data/repository/profileRepositroy.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  Light? _light;
  StreamSubscription? _subscription;

  Future<void> setBrightness(double brightness) async {
    try {
      const maxLightValue = 250.0; // Maximum value of the light sensor
      final clampedBrightness =
          brightness.clamp(0.0, maxLightValue) / maxLightValue;
      await ScreenBrightness().setScreenBrightness(clampedBrightness);
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }

  void onData(int luxValue) async {
    setBrightness(luxValue.toDouble());
  }

  // sensors
  void stopListening() {
    _subscription?.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light?.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopListening();
  }

  Widget build(BuildContext context) {
    final profileRepository = ref.read(profileRemoteRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Either<AppException, List<OrderResponse>>>(
        future: profileRepository.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final appException = AppException(error: snapshot.error.toString());
            return Center(child: Text('${appException.error}'));
          } else if (snapshot.hasData) {
            final orderResponse = snapshot.data!;
            if (orderResponse.isLeft()) {
              final appException = orderResponse.fold(
                (failure) => failure,
                (_) => null,
              );
              final errorMessage = appException?.error ?? 'Unknown error';
              return Center(child: Text(errorMessage));
            } else {
              final orders = orderResponse.fold(
                (_) => [],
                (success) => success,
              );

              if (orders.isEmpty) {
                return const ListTile(
                  title: Text('No orders found'),
                );
              } else {
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    if (order.cartItems == null || order.cartItems!.isEmpty) {
                      return const ListTile(
                        title: Text('No items found'),
                      );
                    } else {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Order ID: ${order.sId ?? ''}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: order.cartItems!.length,
                              itemBuilder: (context, index) {
                                final orderItem = order.cartItems![index];
                                return ListTile(
                                  title: Text(
                                    'Product Name: ${orderItem.productName ?? ''}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price: ${orderItem.productPrice ?? ''}',
                                      ),
                                      Text(
                                        'Quantity: ${orderItem.producQuantity ?? ''}',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Order Total: ${order.totalAmount ?? ''}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Payment: ${order.paymentType ?? ''}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }
            }
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
