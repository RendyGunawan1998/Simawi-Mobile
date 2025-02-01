import 'package:flutter_bloc/flutter_bloc.dart';
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
          title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textInter('Dashboard', Colors.black, FontWeight.w700, 16),
          textInter('Admin', Colors.black87, FontWeight.w300, 14),
        ],
      )),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        builder: (context, state) {
          if (state is DashboardFailure) {
            return Center(child: Text(state.message));
          }

          if (state is DashboardSuccess) {
            return Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      paddingOverview(state),
                      paddingPasienCount(state),
                      paddingPasienSaatIni(state)
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
