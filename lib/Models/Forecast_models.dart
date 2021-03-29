// To parse this JSON data, do
//
//     final forecastWeatherModel = forecastWeatherModelFromJson(jsonString);

import 'dart:convert';

ForecastWeatherModel forecastWeatherModelFromJson(String str) => ForecastWeatherModel.fromJson(json.decode(str));

String forecastWeatherModelToJson(ForecastWeatherModel data) => json.encode(data.toJson());

class ForecastWeatherModel {
  ForecastWeatherModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  String cod;
  num message;
  num cnt;
  List<ListElement> list;
  City city;

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) => ForecastWeatherModel(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    city: City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "city": city.toJson(),
  };
}

class City {
  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  num id;
  String name;
  Coord coord;
  String country;
  num population;
  num timezone;
  num sunrise;
  num sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    coord: Coord.fromJson(json["coord"]),
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coord": coord.toJson(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Coord {
  Coord({
    this.lat,
    this.lon,
  });

  num lat;
  num lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json["lat"],
    lon: json["lon"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}

class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  num dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  num visibility;
  num pop;
  Sys sys;
  DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: MainClass.fromJson(json["main"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: Clouds.fromJson(json["clouds"]),
    wind: Wind.fromJson(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"],
    sys: Sys.fromJson(json["sys"]),
    dtTxt: DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds.toJson(),
    "wind": wind.toJson(),
    "visibility": visibility,
    "pop": pop,
    "sys": sys.toJson(),
    "dt_txt": dtTxt.toIso8601String(),
  };
}

class Clouds {
  Clouds({
    this.all,
  });

  num all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class MainClass {
  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  num temp;
  num feelsLike;
  num tempMin;
  num tempMax;
  num pressure;
  num seaLevel;
  num grndLevel;
  num humidity;
  num tempKf;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"],
    feelsLike: json["feels_like"],
    tempMin: json["temp_min"],
    tempMax: json["temp_max"],
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Sys {
  Sys({
    this.pod,
  });

  Pod pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: podValues.map[json["pod"]],
  );

  Map<String, dynamic> toJson() => {
    "pod": podValues.reverse[pod],
  };
}

enum Pod { D, N }

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  num id;
  MainEnum main;
  String  description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: mainEnumValues.map[json["main"]],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": mainEnumValues.reverse[main],
    "description": description,
    "icon": icon,
  };
}

enum Description { CLEAR_SKY, FEW_CLOUDS, BROKEN_CLOUDS, SCATTERED_CLOUDS, OVERCAST_CLOUDS }

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum MainEnum { CLEAR, CLOUDS }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS
});

class Wind {
  Wind({
    this.speed,
    this.deg,
  });

  num speed;
  num deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"],
    deg: json["deg"],
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
