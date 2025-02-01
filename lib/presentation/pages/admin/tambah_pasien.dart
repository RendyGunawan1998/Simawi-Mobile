import 'dart:math';

import 'package:intl/intl.dart';
import '../../../core.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  PatientBloc patientBloc = PatientBloc(PatientRepository());
  final formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController nik = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();

  DateTime? dateBirth;
  String? _selectedGender;
  String? _bloodType;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    nik.dispose();
    phone.dispose();
    address.dispose();
    weight.dispose();
    height.dispose();
    super.dispose();
  }

  void submitForm(BuildContext context) {
    Random random = Random();
    int id = random.nextInt(1500) * 50;
    final newPatient = Patient(
      id: id,
      recordNumber: id,
      name: _nameController.text,
      birth: DateFormat('yyyy-MM-dd').format(dateBirth!),
      nik: nik.text,
      phone: phone.text,
      address: address.text,
      bloodType: _bloodType!,
      weight: weight.text,
      height: height.text,
      createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      updatedAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    print('newPatient :: ${newPatient.toJson()}');
    patientBloc.add(AddPatient(newPatient));
    Get.snackbar('Success', 'Patient data success added');
    patientBloc.add(LoadPatients());
    Get.offAll(() => AdminPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textInter('Add New Patient', Colors.black, FontWeight.w600, 16),
            textInter('Admin', Colors.black87, FontWeight.w400, 12),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hbox(8),
                tfOutlineBorder('Name', _nameController),
                hbox(15),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () async {
                          dateBirth = await selectDate(context);
                          setState(() {});
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Birth',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            dateBirth != null
                                ? DateFormat('dd MMM yyyy').format(dateBirth!)
                                : 'Select Date',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    wbox(10),
                    Expanded(
                      flex: 5,
                      child: dropdownString('Gender', _selectedGender, [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                            value: 'Female', child: Text('Female')),
                      ], (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      }),
                    ),
                  ],
                ),
                hbox(15),
                tfOutlineBorderNik('NIK', nik),
                hbox(10),
                tfOutlineBorderPhone('Phone', phone),
                hbox(10),
                tfOutlineBorder('Address', address),
                hbox(10),
                dropdownString('Blood Type', _bloodType, [
                  DropdownMenuItem(value: 'A', child: Text('A')),
                  DropdownMenuItem(value: 'B', child: Text('B')),
                  DropdownMenuItem(value: 'AB', child: Text('AB')),
                  DropdownMenuItem(value: 'O', child: Text('O')),
                ], (value) {
                  setState(() {
                    _bloodType = value;
                  });
                }),
                hbox(10),
                tfOutlineBorderNumber('Weight', weight),
                hbox(10),
                tfOutlineBorderNumber('Height', height),
                hbox(15),
                buttonBlue('Add Patient', () {
                  submitForm(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
