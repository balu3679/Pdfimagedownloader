import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/routers.dart';
import 'package:todo_app/config/routes.dart';
import 'package:todo_app/features/presentation/bloc/filebloc/filebloc_bloc.dart';
import 'package:todo_app/utils/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [BlocProvider(create: (context) => FileblocBloc())],
      child: GetMaterialApp(
        title: appTitle,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        getPages: Routers.router,
      ),
    );
  }
}
