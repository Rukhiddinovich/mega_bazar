import 'package:caffelito/bloc/coffee/coffee_bloc.dart';
import 'package:caffelito/bloc/order/order_bloc.dart';
import 'package:caffelito/cubit/tab_box/tab_box_cubit.dart';
import 'package:caffelito/data/firebase/coffee_service.dart';
import 'package:caffelito/data/firebase/order_service.dart';
import 'package:caffelito/presentation/app_routes/app_routes.dart';
import 'package:caffelito/presentation/tab_box/tab_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(
            create: (context) => TabCubit(), child: TabBox()),
        BlocProvider(
            create: (context) => CoffeeBloc(coffeeService: CoffeeService())),
        BlocProvider(
            create: (context) => OrderBloc(orderService: OrderService())),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splash,
          // home: HomeScreen(),
        );
      },
    );
  }
}
