import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/Location_provider.dart';
import 'package:weather_app/Providers/Weather_provider.dart';
import 'package:weather_app/Theme_Style/Text_Style.dart';
import 'package:weather_app/Utils/weather_utils.dart';
import 'package:weather_app/Widgets/Progress_widget.dart';

class CurrentPage extends StatefulWidget {
  @override
  _CurrentPageState createState() => _CurrentPageState();
}
class _CurrentPageState extends State<CurrentPage> with TickerProviderStateMixin {
  bool isLoading = true;
  bool isInit = true;

  WeatherProvider weatherProvider;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() { //Explicit animation
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _controller, curve:Curves.linear);
    _controller.repeat();
    
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    weatherProvider = Provider.of<WeatherProvider>(context);
    if (isInit) {
      weatherProvider.getCurrentData(Provider
          .of<LocationProvider>(context, listen: false)
          .position).then((_) {
        setState(() {
          isLoading = false;
        });
        final lat = weatherProvider.currentWeatherModel.coord.lat;
        final lon = weatherProvider.currentWeatherModel.coord.lon;
        Provider.of <LocationProvider> (context, listen: false).getStreetAddress(lat, lon);
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? ProgressWidget() : Column(
      children: [
        Text(getFormattedDate(weatherProvider.currentWeatherModel.dt, 'EEE,MMM dd,yyy'), style: date),
        SizedBox(height: 12,),

        TweenAnimationBuilder(  //Implicit animation
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          tween: IntTween(
            begin: 0,
            end: weatherProvider.currentWeatherModel.main.temp.round().toInt(),
          ),
          builder: (context, value,_) => Text('$value $degree', style: temperature),
        ),
        SizedBox(height: 12,),
        RichText(
            text: TextSpan(
              text: '${weatherProvider.currentWeatherModel.main.tempMax.round()}$degree',
              style: date,
              children: [
                TextSpan(
                  text: '/${weatherProvider.currentWeatherModel.main.tempMin.round()}$degree',
                  style: date.copyWith(color: Colors.orange),
                )
              ],
            )
        ),
        SizedBox(height: 12,),
        Text ('Feels like ${weatherProvider.currentWeatherModel.main.feelsLike.round()}$degree',
            style:TextStyle(color: Colors.lightBlueAccent) ),
        SizedBox(height: 12,),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 70,
              backgroundColor: Colors.white60,
              progressColor: Colors.red,
              percent: weatherProvider.currentWeatherModel.main.humidity / 100,
              header: Text('Humidity',style: date),
              center: Text('${weatherProvider.currentWeatherModel.main.humidity}%',style: date),
              animation: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('${icon_pre}${weatherProvider.currentWeatherModel.weather[0].icon}${icon_post}',width: 60, height: 60, color: Colors.white,),
                Text(weatherProvider.currentWeatherModel.weather[0].description, style: date,)
              ],
            ),
          ]
        ),
        SizedBox(height: 12,),
        Icon(Icons.location_on,color: Colors.white60,),
        Text('${weatherProvider.currentWeatherModel.name}, ${weatherProvider.currentWeatherModel.sys.country}',style: date,),
        Consumer <LocationProvider> (

            builder: (context, locationProvider,_) =>
             Text(locationProvider.streetAddress,style: TextStyle(color: Colors.white54),)
        ),
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                RotationTransition(  //Explicit animation
                    turns: _animation,
                    child: Image.asset('images/31-Fan-512.png',width: 60, height: 60, fit: BoxFit.cover, color: Colors.white54,))
              ],
            ),
            Column(
              children: [
                Text('Wind Speed : ${weatherProvider.currentWeatherModel.wind.speed}m/s',style: date),
                Text('Wind Speed: ${weatherProvider.currentWeatherModel.wind.deg} $degree',style: date),
              ],
            )
          ],
        )
      ],
    );
  }
}