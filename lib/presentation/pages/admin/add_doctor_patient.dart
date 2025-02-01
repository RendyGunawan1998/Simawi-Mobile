import '../../../core.dart';

class AddPatientDoctorPage extends StatefulWidget {
  final Patient patient;
  const AddPatientDoctorPage({super.key, required this.patient});

  @override
  State<AddPatientDoctorPage> createState() => _AddPatientDoctorPageState();
}

class _AddPatientDoctorPageState extends State<AddPatientDoctorPage> {
  PatientBloc patientBloc = PatientBloc(PatientRepository());
  final TextEditingController symptoms = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();

  bool see = false;
  int? selectedDoctorId;
  List<UserModel> _doctors = [];

  @override
  void initState() {
    super.initState();
    callData();
  }

  callData() async {
    _doctors = await PatientRepository().getDoctorDropdown();
    selectedDoctorId = await PatientRepository()
        .getDoctorByPatientId(widget.patient.recordNumber);
    setState(() {});
  }

  void submitForm(BuildContext context) {
    final newPatient = PatientHistory(
        id: widget.patient.id,
        recordNumber: widget.patient.recordNumber,
        consultationBy: selectedDoctorId!,
        dateVisit: DateTime.now(),
        doctorDiagnose: diagnosisController.text,
        icd10Code: "Wait doctor diagnose",
        icd10Name: "Wait doctor diagnose",
        isDone: false,
        registeredBy: 1,
        symptoms: symptoms.text);
    print('newPatient :: ${newPatient.toJson()}');
    patientBloc.add(AddAppointmentPatient(newPatient));
    Get.snackbar('Success', 'Appointment for patient successfull added');
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
            textInter('Appointment Doctor', Colors.black, FontWeight.w600, 16),
            textInter('Admin', Colors.black87, FontWeight.w400, 12),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hbox(15),
              paddingDataPasien(widget.patient, see, () {
                setState(() {
                  see = !see;
                });
              }),
              hbox(20),
              tff3Line(symptoms, 'Symtomps/Gejala'),
              hbox(10),
              tfOutlineBorder('Diagnosis Awal', diagnosisController),
              hbox(10),
              dropdownInt(
                  'Doctor',
                  selectedDoctorId,
                  _doctors.map((doctor) {
                    return DropdownMenuItem<int>(
                      value: doctor.id!,
                      child: Text(doctor.name),
                    );
                  }).toList(), (value) {
                setState(() {
                  selectedDoctorId = value;
                });
              }),
              hbox(15),
              hbox(35),
              buttonBlue('Add Doctor', () {
                submitForm(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
