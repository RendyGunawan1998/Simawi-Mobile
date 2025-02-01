import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  LoginBloc loginBloc = LoginBloc(DatabaseHelper.instance);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    emailController.text = 'admin@example.com';
    passwordController.text = 'admin123';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: HexColor("#f4f7fd"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                hbox(70),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    AssetsHelper.icRS,
                    height: 100,
                    width: 100,
                  ),
                ),
                hbox(10),
                textInter('SIMAWI', Colors.black, FontWeight.w900, 20),
                hbox(40),
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textInter('Email', Colors.black, FontWeight.w500, 14),
                        hbox(4),
                        tfEmail('Email', emailController),
                        hbox(16),
                        textInter(
                            'Password', Colors.black, FontWeight.w500, 14),
                        hbox(4),
                        tfPass('Password', passwordController, obscureText, () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        }),
                      ],
                    )),
                hbox(20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is LoginLoading) {
                      return CircularProgressIndicator();
                    }
                    return buttonBlue('Log In', () {
                      if (formKey.currentState!.validate()) {
                        final email = emailController.text;
                        final password = passwordController.text;
                        loginBloc.add(PerformLogin(email, password));
                      } else {
                        Get.snackbar('Field Empty',
                            'Please fill the form with some text');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
