// To parse this JSON data, do
//
//     final weature = weatureFromJson(jsonString);

import 'dart:convert';

Weature weatureFromJson(String str) => Weature.fromJson(json.decode(str));

String weatureToJson(Weature data) => json.encode(data.toJson());

class Weature {
  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  double elevation;
  CurrentUnits currentUnits;
  Current current;
  DailyUnits dailyUnits;
  Daily daily;

  Weature({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.dailyUnits,
    required this.daily,
  });

  factory Weature.fromJson(Map<String, dynamic> json) => Weature(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    generationtimeMs: json["generationtime_ms"]?.toDouble(),
    utcOffsetSeconds: json["utc_offset_seconds"],
    timezone: json["timezone"],
    timezoneAbbreviation: json["timezone_abbreviation"],
    elevation: json["elevation"],
    currentUnits: CurrentUnits.fromJson(json["current_units"]),
    current: Current.fromJson(json["current"]),
    dailyUnits: DailyUnits.fromJson(json["daily_units"]),
    daily: Daily.fromJson(json["daily"]),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "current_units": currentUnits.toJson(),
    "current": current.toJson(),
    "daily_units": dailyUnits.toJson(),
    "daily": daily.toJson(),
  };
}

class Current {
  String time;
  int interval;
  double temperature2M;

  Current({
    required this.time,
    required this.interval,
    required this.temperature2M,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    time: json["time"],
    interval: json["interval"],
    temperature2M: json["temperature_2m"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
  };
}

class CurrentUnits {
  String time;
  String interval;
  String temperature2M;

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2M,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => CurrentUnits(
    time: json["time"],
    interval: json["interval"],
    temperature2M: json["temperature_2m"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
  };
}

class Daily {
  List<DateTime> time;
  List<int> weathercode;
  List<double> temperature2MMax;
  List<double> temperature2MMin;
  List<String> sunrise;
  List<String> sunset;

  Daily({
    required this.time,
    required this.weathercode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.sunrise,
    required this.sunset,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
    weathercode: List<int>.from(json["weathercode"].map((x) => x)),
    temperature2MMax: List<double>.from(json["temperature_2m_max"].map((x) => x?.toDouble())),
    temperature2MMin: List<double>.from(json["temperature_2m_min"].map((x) => x?.toDouble())),
    sunrise: List<String>.from(json["sunrise"].map((x) => x)),
    sunset: List<String>.from(json["sunset"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "time": List<dynamic>.from(time.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "weathercode": List<dynamic>.from(weathercode.map((x) => x)),
    "temperature_2m_max": List<dynamic>.from(temperature2MMax.map((x) => x)),
    "temperature_2m_min": List<dynamic>.from(temperature2MMin.map((x) => x)),
    "sunrise": List<dynamic>.from(sunrise.map((x) => x)),
    "sunset": List<dynamic>.from(sunset.map((x) => x)),
  };
}

class DailyUnits {
  String time;
  String weathercode;
  String temperature2MMax;
  String temperature2MMin;
  String sunrise;
  String sunset;

  DailyUnits({
    required this.time,
    required this.weathercode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
    time: json["time"],
    weathercode: json["weathercode"],
    temperature2MMax: json["temperature_2m_max"],
    temperature2MMin: json["temperature_2m_min"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "weathercode": weathercode,
    "temperature_2m_max": temperature2MMax,
    "temperature_2m_min": temperature2MMin,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}
