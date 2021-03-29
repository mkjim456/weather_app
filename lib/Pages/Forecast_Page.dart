import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/Location_provider.dart';
import 'package:weather_app/Providers/Weather_provider.dart';
import 'package:weather_app/Widgets/Progress_widget.dart';
import 'package:weather_app/Widgets/forecast_item.dart';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  bool isLoading =true, isInit =true;
  WeatherProvider weatherProvider;

  @override
  void didChangeDependencies() {
    weatherProvider = Provider.of<WeatherProvider>(context);
    final position = Provider.of <LocationProvider> (context, listen: false).position;
    if(isInit){
      weatherProvider.getForecastData(position).then((_) {
        setState(() {
          isLoading = false;
        });
      });
      isInit = false ;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
   return
     isLoading ? ProgressWidget() : Column(

        children: weatherProvider.forecastWeatherModel.list.map((listElement) =>ForecastItem(listElement)).toList(),


        );



  }
}












