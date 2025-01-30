import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class DoctorPatientPage extends StatefulWidget {
  final int doctorId;

  const DoctorPatientPage({super.key, required this.doctorId});

  @override
  DoctorPatientPageState createState() => DoctorPatientPageState();
}

class DoctorPatientPageState extends State<DoctorPatientPage> {
  DoctorBloc dokterBloc = DoctorBloc();
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    dokterBloc.add(LoadPatientsForDoctorEvent(widget.doctorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients for Doctor'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: () {
                  showMyDialog(
                      context, "Logout", 'Are you sure want to exit the app?',
                      () {
                    Get.offAll(() => LoginScreen());
                  });
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.red,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedFilter,
            items: [
              DropdownMenuItem(value: 'false', child: Text('Belum Dilayani')),
              DropdownMenuItem(value: 'true', child: Text('Sudah Dilayani')),
            ],
            onChanged: (value) {
              setState(() {
                selectedFilter = value;
                dokterBloc.add(FilterPatientsByStatus(
                  selectedFilter!,
                  widget.doctorId,
                ));
              });
            },
            decoration: InputDecoration(
              labelText: 'Status Pelayanan',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: BlocBuilder<DoctorBloc, DoctorState>(
              bloc: dokterBloc,
              builder: (context, state) {
                if (state is DoctorSuccess) {
                  return ListView.builder(
                    itemCount: state.patients.length,
                    itemBuilder: (context, index) {
                      PatientWithHistory patient = state.patients[index];
                      print(
                          '${state.patients[0].patient.name} :: ${state.patients[0].patientHistory['isDone']}');
                      return paddingListPasien(
                          patient,
                          patient.patientHistory['isDone'] == 1
                              ? () {
                                  Get.to(() => UpdateDiagnosePatient(
                                        patient: patient.patient,
                                        patientHistory: patient.patientHistory,
                                        doctorId: widget.doctorId,
                                      ));
                                }
                              : () {
                                  print('history :: ${patient.patientHistory}');
                                  print('patient :: ${patient.patient}');
                                  Get.to(() => DiagnosePatient(
                                        patient: patient.patient,
                                        patientHistory: patient.patientHistory,
                                        doctorId: widget.doctorId,
                                      ));
                                });
                    },
                  );
                } else if (state is DoctorFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
