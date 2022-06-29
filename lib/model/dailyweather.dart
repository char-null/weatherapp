// To parse this JSON data, do
//
//     final dailyWeather = dailyWeatherFromJson(jsonString);

import 'dart:convert';

DailyWeather dailyWeatherFromJson(String str) =>
    DailyWeather.fromJson(json.decode(str));

String dailyWeatherToJson(DailyWeather data) => json.encode(data.toJson());

class DailyWeather {
  DailyWeather({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  Current current;
  List<Current> hourly;
  List<Daily> daily;

  factory DailyWeather.fromJson(Map<String, dynamic> json) => DailyWeather(
        lat: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
        lon: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat ?? 0.0,
        "lon": lon ?? 0.0,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
  });

  int? dt;
  int? sunrise;
  int? sunset;
  double temp;
  double feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int visibility;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather> weather;
  double? pop;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"] ?? 0,
        sunset: json["sunset"] == null ? null : json["sunset"] ?? 0,
        temp: json["temp"] == null ? 0.0 : json["temp"].toDouble(),
        feelsLike:
            json["feels_like"] == null ? 0.0 : json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint:
            json["dew_point"] == null ? 0.0 : json["dew_point"].toDouble(),
        uvi: json["uvi"] == null ? 0.0 : json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed:
            json["wind_speed"] == null ? 0.0 : json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust:
            json["wind_gust"] == null ? 0.0 : json["wind_gust"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        pop: json["pop"] == null ? 0.0 : json["pop"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise == null ? null : sunrise ?? 0,
        "sunset": sunset == null ? null : sunset ?? 0,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint ?? 0.0,
        "uvi": uvi ?? 0.0,
        "clouds": clouds ?? 0.0,
        "visibility": visibility,
        "wind_speed": windSpeed ?? 0.0,
        "wind_deg": windDeg,
        "wind_gust": windGust ?? 0.0,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "pop": pop == null ? null : pop ?? 0.0,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.uvi,
    required this.rain,
  });

  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  double? moonPhase;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather> weather;
  int? clouds;
  double? pop;
  double? uvi;
  double? rain;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"].toDouble() ?? 0.0,
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble() ?? 0.0,
        windSpeed: json["wind_speed"].toDouble() ?? 0.0,
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"].toDouble() ?? 0.0,
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"].toDouble() ?? 0.0,
        uvi: json["uvi"].toDouble() ?? 0.0,
        rain: json["rain"] == null ? null : json["rain"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase ?? 0.0,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint ?? 0.0,
        "wind_speed": windSpeed ?? 0.0,
        "wind_deg": windDeg,
        "wind_gust": windGust ?? 0.0,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop ?? 0.0,
        "uvi": uvi ?? 0.0,
        "rain": rain == null ? null : rain ?? 0.0,
      };
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double? day;
  double? night;
  double? eve;
  double? morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toDouble() ?? 0.0,
        night: json["night"].toDouble() ?? 0.0,
        eve: json["eve"].toDouble() ?? 0.0,
        morn: json["morn"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "day": day ?? 0.0,
        "night": night ?? 0.0,
        "eve": eve ?? 0.0,
        "morn": morn ?? 0.0,
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double? day;
  double min;
  double max;
  double? night;
  double? eve;
  double? morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble() ?? 0.0,
        min: json["min"].toDouble() ?? 0.0,
        max: json["max"].toDouble() ?? 0.0,
        night: json["night"].toDouble() ?? 0.0,
        eve: json["eve"].toDouble() ?? 0.0,
        morn: json["morn"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "day": day ?? 0.0,
        "min": min,
        "max": max,
        "night": night ?? 0.0,
        "eve": eve ?? 0.0,
        "morn": morn ?? 0.0,
      };
}
