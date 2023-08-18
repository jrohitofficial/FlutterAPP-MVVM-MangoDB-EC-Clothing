import 'package:flutter/material.dart';
import 'package:flutter_library_managent/core/failure/failure.dart';
import 'package:flutter_library_managent/features/auth/presentation/widget/animatiom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../providers/state/auth_notifier.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    final token = await ref.read(userSharedPrefsProvider).getUserToken();
    if (token != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/home");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    autoLogin();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? email;
  String? password;

  void handleLogin(BuildContext context, AuthStateNotifier authnotifier) async {
    final result = await authnotifier.login(
      emailController.text,
      passwordController.text,
    );

    result.fold(
      (AppException exception) {
        // Handle login failure

        // Navigator.pushNamed(context, "/register");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(exception.error),
          ),
        );
      },
      (isLoggedIn) {
        // Handle login success
        Navigator.pushNamed(context, "/home");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var authnotifier = ref.watch(authStateNotifierProvider.notifier);
    final authState = ref.watch(authStateNotifierProvider.notifier).state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40.0),
                AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100.0,
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "Trendy Wears ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100.0,
                  duration: const Duration(milliseconds: 1000),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: ValueKey('txtEmail'),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Email address",
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        key: ValueKey('txtPassword'),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Password ",
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        key: ValueKey('btnLogin'),
                        onPressed: () {
                          handleLogin(context, authnotifier);
                        },
                        child: authState.isLoading
                            ? const CircularProgressIndicator() // Show loading indicator
                            : const Text('Access Account'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                const SizedBox(height: 40.0),
                AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100.0,
                  duration: const Duration(milliseconds: 2000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont have an account? : "),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const SignOut(),
                          //     ));
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orSignIn(String image, int duration) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return AnimationWidget(
      axis: Axis.vertical,
      curve: Curves.easeOutExpo,
      offset: 100.0,
      duration: Duration(milliseconds: duration),
      child: Container(
        height: myHeight * 0.08,
        width: myWidth * 0.16,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Image.asset(image, height: 30.0),
        ),
      ),
    );
  }
}
