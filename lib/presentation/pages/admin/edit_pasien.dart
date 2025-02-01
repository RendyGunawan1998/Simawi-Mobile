import 'package:intl/intl.dart';
import '../../../core.dart';

class EditPasienPage extends StatefulWidget {
  final Patient patient;
  const EditPasienPage({super.key, required this.patient});

  @override
  State<EditPasienPage> createState() => _EditPasienPageState();
}

class _EditPasienPageState extends State<EditPasienPage> {
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
    callData();
  }

  callData() async {
    _nameController.text = widget.patient.name;
    nik.text = widget.patient.nik;
    phone.text = widget.patient.phone;
    address.text = widget.patient.address;
    weight.text = widget.patient.weight;
    height.text = widget.patient.height;
    dateBirth = DateFormat('yyyy-MM-dd').parse(widget.patient.birth);
    _bloodType = widget.patient.bloodType;
    setState(() {});
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
    final newPatient = Patient(
      id: widget.patient.id,
      recordNumber: widget.patient.recordNumber,
      name: _nameController.text,
      birth: DateFormat('yyyy-MM-dd').format(dateBirth!),
      nik: nik.text,
      phone: phone.text,
      address: address.text,
      bloodType: _bloodType!,
      weight: weight.text,
      height: height.text,
      createdAt: widget.patient.createdAt,
      updatedAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    patientBloc.add(UpdatePatient(
      newPatient,
    ));
    Get.snackbar('Success', 'Patient data success updated');
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
          textInter('Update Patient', Colors.black, FontWeight.w700, 16),
          textInter('Admin', Colors.black87, FontWeight.w300, 14),
        ],
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                hbox(10),
                buttonBlue('Update Patient', () {
                  if (formkey.currentState!.validate()) {
                    if (dateBirth != null && _selectedGender != null
                        // selectedDoctorId != null &&
                        // symptoms.text != '' &&
                        // diagnosisController.text.isNotEmpty
                        ) {
                      submitForm(context);
                    } else {
                      Get.snackbar('Fill the form',
                          'Check Birth and Gender form to fill with text');
                    }
                  } else {
                    Get.snackbar('Fill the form', 'Please fill the empty form');
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
