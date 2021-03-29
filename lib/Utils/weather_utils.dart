import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart' as gcode;
import 'package:shared_preferences/shared_preferences.dart';


final String weather_api_key = '79d39d54653e973e14c618329840dd41';


final degree = "\u00B0";

String getFormattedDate(num date, String format) => DateFormat(format).
format(DateTime.fromMillisecondsSinceEpoch(date*1000));

final String icon_pre = 'http://openweathermap.org/img/wn/';
final String icon_post = '@2x.png';

const cities = ['Athens', 'Berlin', 'Cairo', 'Dhaka', 'Delhi', 'Jakarta',
 'Karachi', 'Los Angeles', 'London', 'Moscow', 'Milan', 'New york', 'Paris',
 'Riyadh', 'Rome', 'Toronto', 'Tehran', 'Wuhan', 'Yangon'];

Future <String> convertPositionToAddress (double lat, double lon) async {
 final placeMarkList = await gcode.placemarkFromCoordinates(lat, lon);
 return placeMarkList == null ? 'Unknown Address' : '${placeMarkList[0].street} ${placeMarkList[0].subLocality}';
}

Future<Position> convertAddressToPosition(String city) async {
 Position position;
 final locatonList = await gcode.locationFromAddress(city);
 if (locatonList != null) {
  final lat = locatonList.first.latitude;
  final lon = locatonList.first.longitude;
  position = Position(longitude: lon, latitude: lat );
  return position;
 }
 return position;
}

Future setFahrenheitStatus (bool status) async {
final preference = await SharedPreferences.getInstance();
 await preference.setBool('F', status);

}

Future<bool> getFahrenheitStatus() async{
 final preference = await SharedPreferences.getInstance();
 return preference.getBool('F') ?? false ;

}
