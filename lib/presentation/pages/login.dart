import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc(DatabaseHelper.instance);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = 'doctor@example.com';
    passwordController.text = 'doctor123';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsHelper.icRS,
                  height: 150,
                  width: 150,
                ),
                hbox(40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  obscureText: true,
                ),
                hbox(20),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return CircularProgressIndicator();
                    }
                    return buttonBlue('Login', () {
                      final email = emailController.text;
                      final password = passwordController.text;

                      loginBloc.add(PerformLogin(email, password));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
