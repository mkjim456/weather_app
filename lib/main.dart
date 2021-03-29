import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Pages/Weather_home.dart';
import 'package:weather_app/Providers/Location_provider.dart';
import 'Providers/Weather_provider.dart';

void main(){
  runApp (MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     return MultiProvider(
       providers:[
         ChangeNotifierProvider(create: (context) =>LocationProvider() ),
         ChangeNotifierProvider(create: (context) => WeatherProvider() ),
       ],
       child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
          ),

          brightness: Brightness.dark,

        ),

        home: WeatherHome(),

    ),
     );
  }
}
