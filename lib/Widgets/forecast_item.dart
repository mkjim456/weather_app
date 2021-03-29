import 'package:flutter/material.dart';
import 'package:weather_app/Models/Forecast_models.dart';
import 'package:weather_app/Utils/weather_utils.dart';

class ForecastItem extends StatelessWidget {
  final ListElement listElement;

  ForecastItem( this.listElement) ;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(getFormattedDate(listElement.dt, 'EEE HH:mm' )) ,
      subtitle: Text(listElement.weather[0].description),
    );
  }
}
