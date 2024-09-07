import 'dart:convert';

// Location model
class Locations {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  String localtime;
  int localtimeEpoch;

  Locations({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
    required this.localtimeEpoch,
  });

  // From JSON
  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      tzId: json['tz_id'],
      localtime: json['localtime'],
      localtimeEpoch: json['localtime_epoch'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'tz_id': tzId,
      'localtime': localtime,
      'localtime_epoch': localtimeEpoch,
    };
  }
}

// Condition model
class Condition {
  String text;
  String icon;
  int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  // From JSON
  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}

// Current weather model
class Current {
  String lastUpdated;
  int lastUpdatedEpoch;
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windMph;
  double windKph;
  int windDegree;
  String windDir;
  double pressureMb;
  double pressureIn;
  double precipMm;
  double precipIn;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  double windchillC;
  double windchillF;
  double heatindexC;
  double heatindexF;
  double dewpointC;
  double dewpointF;
  double visKm;
  double visMiles;
  double uv;
  double gustMph;
  double gustKph;

  Current({
    required this.lastUpdated,
    required this.lastUpdatedEpoch,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  // From JSON
  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdated: json['last_updated'],
      lastUpdatedEpoch: json['last_updated_epoch'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'],
      windKph: json['wind_kph'],
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'],
      pressureIn: json['pressure_in'],
      precipMm: json['precip_mm'],
      precipIn: json['precip_in'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'],
      feelslikeF: json['feelslike_f'],
      windchillC: json['windchill_c'],
      windchillF: json['windchill_f'],
      heatindexC: json['heatindex_c'],
      heatindexF: json['heatindex_f'],
      dewpointC: json['dewpoint_c'],
      dewpointF: json['dewpoint_f'],
      visKm: json['vis_km'],
      visMiles: json['vis_miles'],
      uv: json['uv'],
      gustMph: json['gust_mph'],
      gustKph: json['gust_kph'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'last_updated': lastUpdated,
      'last_updated_epoch': lastUpdatedEpoch,
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition.toJson(),
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure_mb': pressureMb,
      'pressure_in': pressureIn,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'feelslike_f': feelslikeF,
      'windchill_c': windchillC,
      'windchill_f': windchillF,
      'heatindex_c': heatindexC,
      'heatindex_f': heatindexF,
      'dewpoint_c': dewpointC,
      'dewpoint_f': dewpointF,
      'vis_km': visKm,
      'vis_miles': visMiles,
      'uv': uv,
      'gust_mph': gustMph,
      'gust_kph': gustKph,
    };
  }
}

// Weather data model that combines Location and Current weather
class WeatherData {
  Locations location;
  Current current;

  WeatherData({
    required this.location,
    required this.current,
  });

  // From JSON
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: Locations.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
    };
  }
}
