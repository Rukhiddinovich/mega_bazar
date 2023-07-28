import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mega_bazar/data/firebase/auth_service.dart';
import 'package:mega_bazar/data/firebase/profile_service.dart';
import 'package:mega_bazar/providers/auth_provider.dart';
import 'package:mega_bazar/providers/profile_provider.dart';
import 'package:mega_bazar/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(firebaseServices: AuthService()),
          lazy: true,
        ),
        ChangeNotifierProvider(create: (context)=>ProfileProvider(profileService: ProfileService()),
        lazy: true,)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
