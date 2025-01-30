import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../core.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    dashboardBloc.add(LoadDashboardDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        builder: (context, state) {
          if (state is DashboardFailure) {
            return Center(child: Text(state.message));
          }

          if (state is DashboardSuccess) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    '5 Kode Diagnosis ICD-10 Terpopuler:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  hbox(10),
                  Container(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      dataMap: getDataMap(state.topICDCodes),
                      chartType: ChartType.disc,
                      chartValuesOptions:
                          ChartValuesOptions(showChartValues: true),
                      legendOptions: LegendOptions(showLegends: true),
                    ),
                  )
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Map<String, double> getDataMap(List<ICD10Diagnosis> topICDCodes) {
    Map<String, double> dataMap = {};
    for (var icd in topICDCodes) {
      dataMap[icd.icd10Code] = icd.count.toDouble();
    }
    return dataMap;
  }
}
