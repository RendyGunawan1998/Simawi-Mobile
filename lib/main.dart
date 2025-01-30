import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simawi/core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(DatabaseHelper.instance),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => PatientBloc(PatientRepository()),
        ),
        BlocProvider(
          create: (context) => DoctorBloc(),
        ),
        BlocProvider(
          create: (context) =>
              IcdBloc(ICDRepository(icdAPIProvider: ICDAPIProvider())),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIMAWI Mobile',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
