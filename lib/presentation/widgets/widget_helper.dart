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
            color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}

tffSuffix(TextEditingController cont, String label, IconData icon,
    Function() funcSuff) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      suffixIcon: InkWell(onTap: funcSuff, child: Icon(icon)),
    ),
  );
}

tffType(TextEditingController cont, String label, TextInputType type) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    keyboardType: type,
  );
}

tff(TextEditingController cont, String label) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

tff3Line(TextEditingController cont, String label) {
  return TextField(
    expands: false,
    maxLines: 3,
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

tffOnlyRead(TextEditingController cont, String label) {
  return TextField(
    expands: false,
    controller: cont,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
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
        InkWell(
          onTap: funcTap,
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
            color: Colors.blue,
          ),
        ),
      ),
    ],
    title: Text('Admin - Patient Management'),
  );
}

rowSearch(
    TextEditingController cont, Function() funcSearch, Function() funcClear) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
          child: tffSuffix(cont, 'Search by name', Icons.search, funcSearch)),
      wbox(5),
      InkWell(
          onTap: funcClear,
          child: Icon(
            Icons.clear,
          )),
    ],
  );
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
                        Text(patient.patientHistory['isDone'] == true
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
