import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Utils/weather_utils.dart';


class LocationProvider extends ChangeNotifier{
  Position position;
  String streetAddress = '';

  Future getDeviceCurrentPosition () async{
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    notifyListeners();
}
  getStreetAddress (double lat, double lon) async {
     streetAddress = await convertPositionToAddress(lat, lon);
     notifyListeners();
  }
 void setNewSearchPosition(Position position){
    this.position = position;
    notifyListeners();
 }

}