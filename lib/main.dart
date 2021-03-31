import 'package:QuatesApp/UI/Home/View/HomePage.dart';
import 'package:QuatesApp/UI/Models/provider_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderModel>(
      create: (context) {
        return ProviderModel(darkMode: false);
      },
      child: Consumer<ProviderModel>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          title: 'Quotes App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Provider.of<ProviderModel>(context).darkMode ?? false
                ? Brightness.dark
                : Brightness.light,
            appBarTheme: AppBarTheme(
              elevation: 0,
            ),
            primaryColor: Color(0xFFFFFFFF),
            primarySwatch: Colors.cyan,
            buttonColor: Colors.cyan,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
        );
      }),
    );
  }
}
