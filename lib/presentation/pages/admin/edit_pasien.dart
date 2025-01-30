import 'package:intl/intl.dart';
import '../../../core.dart';

class EditPasienPage extends StatefulWidget {
  final CombinedUserPatient combine;
  const EditPasienPage({super.key, required this.combine});

  @override
  State<EditPasienPage> createState() => _EditPasienPageState();
}

class _EditPasienPageState extends State<EditPasienPage> {
  PatientBloc patientBloc = PatientBloc(PatientRepository());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();

  String? selectedValue;
  String? _selectedGender;
  DateTime? _selectedDate;
  int? selectedDoctorId;

  List<UserModel> _doctors = [];
  List<DestinationEntity> data = [];

  @override
  void initState() {
    super.initState();

    callData();
  }

  callData() async {
    _doctors = await PatientRepository().getDoctorDropdown();
    _nameController.text =
        widget.combine.patient?.name ?? widget.combine.user!.name;
    String? diagnosis = await PatientRepository()
        .getDiagnosaByPatientId(widget.combine.patient!.recordNumber);
    _diagnosisController.text = diagnosis!;
    selectedDoctorId = await PatientRepository()
        .getDoctorByPatientId(widget.combine.patient!.recordNumber);

    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _diagnosisController.dispose();
    super.dispose();
  }

  void submitForm(BuildContext context) {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    final gender = _selectedGender;
    final diagnosis = _diagnosisController.text.trim();
    final date = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : null;
    final doctor = selectedDoctorId;

    if (name.isEmpty ||
        age <= 0 ||
        gender == null ||
        diagnosis.isEmpty ||
        date == null ||
        doctor == null) {
      Get.snackbar('Alert', 'Please fill all the form');
      return;
    }

    final newPatient = Patient(
      id: widget.combine.patient!.id,
      recordNumber: widget.combine.patient!.recordNumber,
      name: name,
      birth: '',
      nik: '',
      phone: '',
      address: '',
      bloodType: '',
      weight: 0.0,
      height: 0.0,
      createdAt: date,
      updatedAt: date,
    );
    patientBloc.add(UpdatePatient(
        newPatient,
        doctor,
        1,
        _diagnosisController.text,
        DateFormat('dd MMM yyyy').format(_selectedDate!)));
    Get.snackbar('Success', 'Patient data success updated');
    patientBloc.add(LoadPatients());
    Get.offAll(() => AdminPage());
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Patient'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              hbox(15),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: tffType(_ageController, 'Age', TextInputType.number),
                  ),
                  wbox(10),
                  Expanded(
                    flex: 5,
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      items: [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                            value: 'Female', child: Text('Female')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              hbox(15),
              tffSuffix(
                  _diagnosisController, 'Diagnosis (ICD-10)', Icons.search,
                  () async {
                data = await ICDRepository(icdAPIProvider: ICDAPIProvider())
                    .searchICD(_diagnosisController.text);
                setState(() {});
              }),
              hbox(15),
              data.isEmpty
                  ? hbox(0)
                  : DropdownButton<String>(
                      isExpanded: true,
                      value: selectedValue,
                      hint: Text('Pilih ICD'),
                      items: data.map((item) {
                        String displayId = extractId(item.id);
                        var title =
                            item.title.replaceAll("<em class='found'>", '');
                        title = title.replaceAll("</em>", '');
                        return DropdownMenuItem<String>(
                          value: displayId,
                          child: Text(title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                        print('Selected value: $selectedValue');
                      },
                    ),
              data.isEmpty ? hbox(0) : hbox(15),
              GestureDetector(
                onTap: () {
                  selectDate(context);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Examination Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat('dd MMM yyyy').format(_selectedDate!)
                        : 'Select Date',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              hbox(15),
              DropdownButtonFormField<int>(
                value: selectedDoctorId,
                items: _doctors.map((doctor) {
                  return DropdownMenuItem<int>(
                    value: doctor.id!,
                    child: Text(doctor.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDoctorId = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Doctor',
                  border: OutlineInputBorder(),
                ),
              ),
              hbox(35),
              buttonBlue('Update Patient', () {
                submitForm(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
