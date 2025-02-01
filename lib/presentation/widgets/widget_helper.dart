import 'package:simawi/core.dart';

hbox(double h) {
  return SizedBox(height: h);
}

wbox(double w) {
  return SizedBox(width: w);
}

buttonBlue(String title, Function() func) {
  return Padding(
    padding: EdgeInsets.all(12),
    child: InkWell(
      onTap: func,
      child: Container(
        height: Get.height * 0.06,
        width: Get.width,
        decoration: BoxDecoration(
            color: HexColor('#5893FF'),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}

paddingData(String assets, String titleNama, String role, Function() funcEdit,
    Function() funcDel) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      children: [
        Container(
          width: Get.width,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.7, color: Colors.black87)),
                child: Image.asset(
                  assets,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              wbox(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleNama,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  hbox(4),
                  Text(
                    role,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: funcEdit,
                        child: Image.asset(
                          AssetsHelper.icEditing,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      wbox(10),
                      InkWell(
                        onTap: funcDel,
                        child: Image.asset(
                          AssetsHelper.icBin,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[400],
          indent: 90,
        )
      ],
    ),
  );
}

paddingDataAdmin(Function() funcTap, String assets, String titleNama,
    String role, Function() funcEdit, Function() funcDel) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      children: [
        Container(
          width: Get.width,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.7, color: Colors.black87)),
                child: Image.asset(
                  assets,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              wbox(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textInter(titleNama, Colors.black, FontWeight.bold, 16),
                  hbox(2),
                  textInter(role, Colors.black87, FontWeight.w600, 14),
                  hbox(6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: funcEdit,
                        child: Image.asset(
                          AssetsHelper.icEditing,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      wbox(10),
                      InkWell(
                        onTap: funcDel,
                        child: Image.asset(
                          AssetsHelper.icBin,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      role != "Patient" ? wbox(0) : wbox(10),
                      role != "Patient"
                          ? wbox(0)
                          : InkWell(
                              onTap: funcTap,
                              child: Container(
                                width: Get.width * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue[100]),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Center(
                                    child: textInter('+Pilih Dokter',
                                        Colors.black, FontWeight.bold, 12),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[400],
          indent: 90,
        )
      ],
    ),
  );
}

appbarAdmin(BuildContext context) {
  return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Image.asset(
          AssetsHelper.imgProfile,
          height: 15,
          width: 15,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.to(() => DashboardPage());
          },
          child: Icon(
            Icons.dashboard,
            color: Colors.grey,
          ),
        ),
        wbox(10),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              showMyDialog(
                  context, "Logout", 'Are you sure want to exit the app?', () {
                Get.offAll(() => LoginScreen());
              });
            },
            child: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ),
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textInter('Patient Management', Colors.black, FontWeight.w700, 16),
          textInter('Admin', Colors.black87, FontWeight.w300, 14),
        ],
      ));
}

AppBar appBarDoctor(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Image.asset(
        AssetsHelper.imgProfile,
        height: 15,
        width: 15,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textInter('List Patient', Colors.black, FontWeight.w700, 16),
        textInter('Doctor', Colors.black87, FontWeight.w300, 14),
      ],
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 15),
        child: InkWell(
            onTap: () {
              showMyDialog(
                  context, "Logout", 'Are you sure want to exit the app?', () {
                Get.offAll(() => LoginScreen());
              });
              // dokterBloc.add(LoadPatientsForDoctorEvent(widget.doctorId));
            },
            child: Icon(
              Icons.logout,
              color: Colors.red,
            )),
      )
    ],
  );
}

rowSearch(
  TextEditingController cont,
  Function() funcSearch,
) {
  return tffSearch(cont, 'Search by name', Icons.search, funcSearch);
}

paddingListPasien(PatientWithHistory patient, Function() func) {
  return Padding(
    padding: EdgeInsets.all(12),
    child: Column(
      children: [
        InkWell(
          onTap: func,
          child: Container(
            width: Get.width,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.7, color: Colors.black87)),
                  child: Image.asset(
                    AssetsHelper.icPasien,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                wbox(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.patient.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    hbox(4),
                    Text(
                      'Record Number : ${patient.patient.recordNumber.toString()}',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Row(
                      children: [
                        Icon(
                          patient.patientHistory['isDone'] == true ||
                                  patient.patientHistory['isDone'] == 1
                              ? Icons.check_box
                              : Icons.cancel,
                          color: patient.patientHistory['isDone'] == false ||
                                  patient.patientHistory['isDone'] == 0
                              ? Colors.grey
                              : Colors.green,
                        ),
                        wbox(8),
                        Text(patient.patientHistory['isDone'] == 1
                            ? 'Patient already done diagnose'
                            : 'Patient need diagnose')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[400],
          indent: 90,
        ),
      ],
    ),
  );
}

paddingDataPasien(Patient patient, bool see, Function() func) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.7, color: Colors.black87)),
                child: Image.asset(
                  AssetsHelper.icPasien,
                  height: 55,
                  width: 55,
                  fit: BoxFit.cover,
                ),
              ),
              wbox(12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textInter(patient.name, Colors.black, FontWeight.bold, 16),
                  hbox(4),
                  textInter(
                      'Record Number : ${patient.recordNumber.toString()}',
                      Colors.black87,
                      FontWeight.w600,
                      14),
                  hbox(4),
                  textInter('NIK : ${patient.nik}', Colors.black87,
                      FontWeight.w600, 14),
                ],
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[400],
            indent: 90,
          ),
          see == false
              ? hbox(0)
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textInter('Birth : ${patient.birth}', Colors.black87,
                              FontWeight.w600, 14),
                          hbox(4),
                          textInter('Phone Number : ${patient.phone}',
                              Colors.black87, FontWeight.w600, 14),
                          hbox(4),
                          textInter('Address : ${patient.address}',
                              Colors.black87, FontWeight.w600, 14),
                          hbox(4),
                        ],
                      ),
                    ),
                    wbox(15),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textInter('Blood Type : ${patient.bloodType}',
                              Colors.black87, FontWeight.w600, 14),
                          hbox(4),
                          textInter('Weight (kg) : ${patient.weight}',
                              Colors.black87, FontWeight.w600, 14),
                          hbox(4),
                          textInter('Height (Cm) : ${patient.height}',
                              Colors.black87, FontWeight.w600, 14),
                        ],
                      ),
                    )
                  ],
                ),
          hbox(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: func,
                child: textInter(see == false ? "+See More" : "-See less",
                    Colors.blue[300]!, FontWeight.w600, 14),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Future<void> showMyDialog(BuildContext context, String title, String subtitle,
    Function() funcYes) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: funcYes,
          ),
        ],
      );
    },
  );
}

DropdownButtonFormField<String> dropdownString(String title, String? value,
    List<DropdownMenuItem<String>>? items, Function(String?)? onChanged) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

dropdownStringRadius(String title, String? value,
    List<DropdownMenuItem<String>>? items, Function(String?)? onChanged) {
  return Container(
    padding: EdgeInsets.only(
      left: 15,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black87, width: 0.8)),
    child: DropdownButtonFormField<String>(
      icon: SizedBox(),
      value: value,
      isExpanded: true,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down_outlined),
        labelText: title,
        border: InputBorder.none,
      ),
    ),
  );
}

DropdownButtonFormField<String> dropdownStringExpand(
    String title,
    String? value,
    List<DropdownMenuItem<String>>? items,
    Function(String?)? onChanged) {
  return DropdownButtonFormField<String>(
    isExpanded: true,
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

DropdownButtonFormField<int> dropdownInt(String title, int? value,
    List<DropdownMenuItem<int>>? items, Function(int?)? onChanged) {
  return DropdownButtonFormField<int>(
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

Padding paddingPasienSaatIni(DashboardSuccess state) {
  return Padding(
    padding: EdgeInsets.all(6),
    child: Container(
        width: Get.width,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[500]!, width: 0.4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textInter('Pasien saat ini ', Colors.black, FontWeight.w600, 32),
            ListView.builder(
                shrinkWrap: true,
                itemCount: state.recentPatients.length,
                itemBuilder: (BuildContext context, i) {
                  return Padding(
                    padding: EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.black54, width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          AssetsHelper.icPasien,
                          height: 40,
                        ),
                        title: textInter(
                            'Nama  : ${state.recentPatients[i].name}',
                            Colors.black,
                            FontWeight.w600,
                            14),
                        subtitle: textInter(
                            'Phone : ${state.recentPatients[i].phone}',
                            Colors.black,
                            FontWeight.w600,
                            14),
                      ),
                    ),
                  );
                }),
          ],
        )),
  );
}

Padding paddingPasienCount(DashboardSuccess state) {
  return Padding(
    padding: EdgeInsets.all(6),
    child: Container(
      height: Get.height * 0.18,
      width: Get.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[500]!, width: 0.4),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textInter(state.patientCount.toString(), Colors.black,
                  FontWeight.w600, 32),
              wbox(10),
              Icon(
                Icons.trending_up_sharp,
                color: Colors.green,
                size: 40,
              )
            ],
          ),
          hbox(10),
          textInter('Jumlah Pasien', Colors.black, FontWeight.w400, 12)
        ],
      ),
    ),
  );
}

Padding paddingOverview(DashboardSuccess state) {
  return Padding(
    padding: EdgeInsets.all(6),
    child: Container(
      width: Get.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[500]!, width: 0.4),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textInter('Overview', Colors.black, FontWeight.w900, 18)
            ],
          ),
          hbox(10),
          PieChart(
            dataMap: getDataMap(state.topICDCodes),
            chartType: ChartType.disc,
            chartValuesOptions: ChartValuesOptions(showChartValues: true),
            legendOptions: LegendOptions(showLegends: true),
          ),
          hbox(10),
          textInter('5 Kode Diagnosis(ICD-10) yang paling banyak digunakan',
              Colors.black, FontWeight.w900, 14)
        ],
      ),
    ),
  );
}
