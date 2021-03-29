import 'package:flutter/material.dart';
import 'package:weather_app/Theme_Style/Text_Style.dart';
import 'package:weather_app/Utils/weather_utils.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isFahrenheit = false;

  @override
  void initState() {
    getFahrenheitStatus().then((value) {
      setState(() {
        isFahrenheit = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: Text('Settings', style: title,),
      ),

      body: Container(
           decoration: BoxDecoration(
           color: Colors.black54
           ),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Show Temperature in Fahrenheit',style: date),
              subtitle: Text('Default is Celsius',style: TextStyle(fontSize: 14, color: Colors.white70)),
              value: isFahrenheit,
              onChanged: (value) async {
                setState(() {
                  isFahrenheit = value;
                });
               await setFahrenheitStatus(value);
              },
            )
          ],

        ),
      ),
    );
  }
}
