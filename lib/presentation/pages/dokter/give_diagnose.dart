import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class DiagnosePatient extends StatefulWidget {
  final Map<String, dynamic> patientHistory;
  final Patient patient;
  final int doctorId;
  const DiagnosePatient(
      {super.key,
      required this.patientHistory,
      required this.patient,
      required this.doctorId});

  @override
  DiagnosePatientState createState() => DiagnosePatientState();
}

class DiagnosePatientState extends State<DiagnosePatient> {
  IcdBloc icdBloc = IcdBloc(ICDRepository(icdAPIProvider: ICDAPIProvider()));
  final diagnosaController = TextEditingController();
  final nameController = TextEditingController();
  final gejalaController = TextEditingController();
  final icdDiagnose = TextEditingController();
  final symtomp = TextEditingController();
  String? selectedValue;

  List diagnosaSynonym = [];
  List<DestinationEntity> data = [];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.patient.patient!.name;
    gejalaController.text = widget.patientHistory['DoctorDiagnose'];
    symtomp.text = widget.patientHistory['Symptoms'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textInter('Rekam Medis', Colors.black, FontWeight.w700, 16),
          textInter('Doctor', Colors.black87, FontWeight.w300, 14),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200]),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            AssetsHelper.icPasien,
                            height: 120,
                            width: 120,
                          ),
                          hbox(4),
                          Text(
                            nameController.text,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      wbox(15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Diagnosa Awal : ${gejalaController.text}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            hbox(4),
                            tff3Line(symtomp, 'Keluhan'),
                            hbox(8),
                            tffSuffix(diagnosaController, 'Masukkan Diagnosa',
                                Icons.search, () async {
                              if (diagnosaController.text.isNotEmpty) {
                                data = await ICDRepository(
                                        icdAPIProvider: ICDAPIProvider())
                                    .searchICD(diagnosaController.text);
                              } else {
                                Get.snackbar('Alert',
                                    'Please fill something inside the form');
                              }
                              setState(() {});
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              hbox(15),
              data.isEmpty
                  ? hbox(0)
                  : Padding(
                      padding: EdgeInsets.all(6),
                      child:
                          textInter('ICD', Colors.black, FontWeight.w600, 16),
                    ),
              data.isEmpty ? hbox(0) : hbox(5),
              data.isEmpty
                  ? hbox(0)
                  : Padding(
                      padding: EdgeInsets.all(6),
                      child: dropdownStringRadius(
                          'Pilih ICD',
                          selectedValue,
                          data.map((item) {
                            String displayId = extractId(item.id);
                            var title =
                                item.title.replaceAll("<em class='found'>", '');
                            title = title.replaceAll("</em>", '');
                            return DropdownMenuItem<String>(
                              value: displayId,
                              child: Text(title),
                            );
                          }).toList(), (value) {
                        setState(() {
                          selectedValue = value;
                          final diagnosa = diagnosaController.text.trim();
                          if (diagnosa.isNotEmpty) {
                            icdBloc.add(
                                FetchIcdDetailsEvent(selectedValue.toString()));
                          } else {
                            Get.snackbar(
                                'Choose Diagnose', 'Fill diagnose form first');
                          }
                        });
                        print('Selected value: $selectedValue');
                      })),
              // data.isEmpty ? hbox(0) : hbox(10),
              // selectedValue == null || selectedValue == ""
              //     ? hbox(0)
              //     : buttonBlue('Tampilkan Deskripsi Penyakit', () {

              //       }),
              data.isEmpty ? hbox(0) : hbox(10),
              BlocBuilder<IcdBloc, IcdState>(
                bloc: icdBloc,
                builder: (context, state) {
                  if (state is IcdSuccess) {
                    final icdData = state.icdDetails;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                                border: Border.all(
                                    color: Colors.black87, width: 0.4)),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Judul: ${icdData['title']['@value']}'),
                                  hbox(10),
                                  icdData['definition'] == null
                                      ? hbox(0)
                                      : Text(
                                          'Deskripsi: ${icdData['definition']['@value']}'),
                                  icdData['definition'] == null
                                      ? hbox(0)
                                      : hbox(10),
                                  icdData['synonym'] == null
                                      ? hbox(0)
                                      : Text(
                                          'Sinonym: ${icdData['synonym'].map((e) => e['label']['@value']).join(', ')}'),
                                  icdData['synonym'] == null
                                      ? hbox(0)
                                      : hbox(10),
                                  Text(
                                      'Child: ${(icdData['child'] as List?)?.join(', ').replaceAll('http://id.who.int/icd/entity/', '') ?? 'No child entities'}'),
                                  hbox(10),
                                  Text(
                                      'Parent: ${(icdData['parent'] as List?)?.join(', ').replaceAll('http://id.who.int/icd/entity/', '') ?? 'No parent entities'}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        hbox(10),
                        buttonBlue('Save Rekam Medis', () {
                          submitForm(context, icdData);
                        }),
                      ],
                    );
                  }
                  if (state is IcdFailure) {
                    return Text('Error: ${state.error}');
                  }
                  if (state is IcdLoading) {
                    return Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        hbox(8),
                        Text('Harap tunggu...')
                      ],
                    ));
                  }
                  return hbox(0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitForm(BuildContext context, Map<String, dynamic> icdData) async {
    if (symtomp.text.isEmpty || diagnosaController.text.isEmpty) {
      Get.snackbar('Alert', 'Please fill all the form');
      return;
    }
    final ICDAPIProvider icdapiProvider = ICDAPIProvider();
    Map<String, dynamic> ph = widget.patientHistory;
    await icdapiProvider.submitMedicalRecord(
        recordNumber: ph['RecordNumber'],
        registeredBy: ph['RegisteredBy'],
        dateVisit: ph['DateVisit'],
        consultationBy: ph['ConsultationBy'],
        symptoms: symtomp.text,
        doctorDiagnose: diagnosaController.text,
        icd10Code: selectedValue!,
        icd10Name: icdData['title']['@value'],
        id: widget.patient.id,
        date: widget.patient.createdAt,
        name: widget.patient.name);
    Get.offAll(() => DoctorPatientPage(
          doctorId: widget.doctorId,
        ));
  }
}
