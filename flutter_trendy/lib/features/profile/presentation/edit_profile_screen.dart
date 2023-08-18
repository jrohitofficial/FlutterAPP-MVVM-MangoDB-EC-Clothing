import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/model/user_model.dart';
import '../data/model/profileResponse.dart';
import '../data/repository/profileRepositroy.dart';
import 'profile_screen.dart';

class ProfileUpdatePage extends ConsumerStatefulWidget {
  final ProfileResponse profile;

  const ProfileUpdatePage({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends ConsumerState<ProfileUpdatePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.profile.user?.name.toString());
    _emailController =
        TextEditingController(text: widget.profile.user?.email.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileRepository = ref.read(profileRemoteRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () async {
                  // Create the updated user model
                  final updatedProfile = UserModel(
                    name: _nameController.text,
                    email: _emailController.text,
                  );

                  // Call the update profile API
                  final result =
                      await profileRepository.updateProfile(updatedProfile);

                  result.fold(
                    (error) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.error.toString()),
                        ),
                      );
                    },
                    (success) {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully'),
                        ),
                      );
                    },
                  );

                  // Navigate back to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                icon: Icon(Icons.update),
                label: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
