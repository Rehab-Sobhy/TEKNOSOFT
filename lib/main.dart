import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layout/layout_screen.dart';
import 'package:new_app/modules/Screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:new_app/shared/constants/constants.dart';
import 'package:new_app/shared/network/local_network.dart';
import 'package:new_app/track2.dart';
import 'package:new_app/tracking.dart';
import 'layout/layout_cubit/layout_cubit.dart';
import 'modules/Screens/splash_screen/splash_screen.dart';
import 'shared/bloc_observer/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  userToken = await CacheNetwork.getCacheData(key: 'token');
  currentPassword = await CacheNetwork.getCacheData(key: 'password');
  debugPrint("User token is : $userToken");
  debugPrint("Current Password is : $currentPassword");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getCarts()
              ..getFavorites()
              ..getBannersData()
              ..getCategoriesData()
              ..getProducts()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: 
          userToken != null ? const LayoutScreen() : const SplashScreen()

          ),
    );
  }
}
