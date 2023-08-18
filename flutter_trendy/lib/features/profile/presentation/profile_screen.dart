import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library_managent/features/profile/presentation/change_password.dart';
import 'package:flutter_library_managent/features/profile/presentation/edit_profile_screen.dart';
import 'package:flutter_library_managent/features/profile/presentation/my_orders_screen.dart';
import 'package:flutter_library_managent/features/profile/data/model/profileResponse.dart';
import 'package:flutter_library_managent/features/profile/data/repository/profileRepositroy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';
import '../../../core/failure/failure.dart';
import '../../../core/shared_prefs/user_shared_prefs.dart';

// ignore: must_be_immutable
class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileRepository = ref.read(profileRemoteRepositoryProvider);

    void logout(BuildContext context, WidgetRef ref) {
      ref.read(userSharedPrefsProvider).deleteUserToken();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

    void showLogoutAlert(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  logout(context, ref);
                },
              ),
            ],
          );
        },
      );
    }

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        showLogoutAlert(context); // Show the logout alert on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // Initialize the shake detector when the widget is first built
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      detector.startListening();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<Either<AppException, ProfileResponse>>(
        future: profileRepository.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final result = snapshot.data!;
            return result.fold(
              (error) => Text('Error: ${error.error}'),
              (profile) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-icon/user_318-159711.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    profile.user!.email.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Profile'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProfileUpdatePage(
                            profile: profile,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('My Orders'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const OrderDetailsScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change Password'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordPage(),
                        ),
                      );
                      // Add your logic here for handling the change password action
                    },
                  ),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Sign Out'),
                      onTap: () {
                        showLogoutAlert(context);
                        // ref.read(userSharedPrefsProvider).deleteUserToken();
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/login', (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
