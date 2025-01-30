import '../../../core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  late TextEditingController _searchController;
  PatientBloc patientBloc = PatientBloc(PatientRepository());

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    patientBloc.add(LoadPatients());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onSearch() {
    final query = _searchController.text.trim();
    patientBloc.add(SearchPatientByName(query));
  }

  void onDelete(int patientId) {
    patientBloc.add(DeletePatient(patientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarAdmin(context),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            rowSearch(_searchController, () {
              onSearch();
            }, () {
              setState(() {
                _searchController.clear();
                patientBloc.add(LoadPatients());
              });
            }),
            hbox(15),
            Expanded(
              child: BlocBuilder<PatientBloc, PatientState>(
                bloc: patientBloc,
                builder: (context, state) {
                  if (state is PatientError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  if (state is PatientLoaded) {
                    final data = state.combinedData;
                    if (data.isEmpty) {
                      return Center(child: Text('No data found.'));
                    }
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final datas = data[index];

                          return paddingDataAdmin(
                              () {
                                datas.user?.role != "Admin" &&
                                        datas.user?.role != "Doctor"
                                    ? Get.to(() => AddPatientDoctorPage(
                                        patient: datas.patient!))
                                    : print('admin doktor');
                              },
                              datas.user?.role == "Admin"
                                  ? AssetsHelper.icAdmin
                                  : datas.user?.role == "Doctor"
                                      ? AssetsHelper.icDokter
                                      : AssetsHelper.icPasien,
                              datas.patient?.name ?? datas.user?.name ?? '',
                              datas.user?.role ?? 'Patient',
                              () {
                                Get.to(() => EditPasienPage(
                                      combine: datas,
                                    ));
                              },
                              () {
                                showMyDialog(context, 'Delete?',
                                    'Are you sure want to delete this data?',
                                    () {
                                  datas.user?.role == "Admin" ||
                                          datas.user?.role == "Doctor"
                                      ? onDelete(datas.user?.id ?? 0)
                                      : onDelete(datas.patient!.id);
                                });
                              });
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttonBlue('+Tambah Pasien Baru', () {
        Get.to(() => AddPatientPage());
      }),
    );
  }
}
