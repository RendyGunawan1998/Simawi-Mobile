import '../../../core.dart';

class EditUserPage extends StatefulWidget {
  final UserModel user;
  const EditUserPage({super.key, required this.user});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  PatientBloc patientBloc = PatientBloc(PatientRepository());
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    name.text = widget.user.name;
    email.text = widget.user.email;
    pass.text = widget.user.password;
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    name.dispose();
    super.dispose();
  }

  void submitForm(BuildContext context) {
    final updatedUser = UserModel(
      id: widget.user.id!,
      name: name.text,
      email: email.text,
      password: pass.text,
      role: widget.user.role,
      createdAt: widget.user.createdAt,
      updatedAt: DateTime.now(),
    );
    print('Update user :: ${updatedUser.toJson()}');
    patientBloc.add(UpdateUserEvent(updatedUser));
    Get.snackbar('Success', 'Data user success updated');
    Get.offAll(() => AdminPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textInter('Update User', Colors.black, FontWeight.w700, 16),
          textInter('Admin', Colors.black87, FontWeight.w300, 14),
        ],
      )),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textInter('Name', Colors.black, FontWeight.w500, 14),
                    hbox(4),
                    tfName('Name', name),
                    hbox(16),
                    textInter('Email', Colors.black, FontWeight.w500, 14),
                    hbox(4),
                    tfEmail('Email', email),
                    hbox(16),
                    textInter('Password', Colors.black, FontWeight.w500, 14),
                    hbox(4),
                    tfPass('Password', pass, obscureText, () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    }),
                  ],
                ),
                hbox(35),
                buttonBlue('Update User Data', () {
                  if (formKey.currentState!.validate()) {
                    submitForm(context);
                  } else {
                    Get.snackbar('Fill the form', 'Please fill the form');
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
