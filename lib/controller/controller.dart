import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/clothes_json.dart';
import 'package:weatherapp/data/clothesjson.dart';
import 'package:weatherapp/data/product.dart';
import 'package:weatherapp/model/dailyweather.dart';
import 'package:weatherapp/model/currentweather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  CurrentWeather? data;
  DailyWeather? data2;
  late DateFormat daysFormat;
  late DateFormat daysFormat2;
  late double latitude;
  late double longitude;
  List clothes = clothes_json;
  List<Map<String, dynamic>> clothes2 = clothesjson;
  final random = Random();
  Map<String, dynamic>? top;
  Map<String, dynamic>? bottoms;
  int tabindex = 0;
  int menuindex = 0;
  int myroommenuindex = 0;
  String myroomdefalttop = '';
  String myroomdefaltbottoms = '';
  String defalttop = 'assets/images/jacket.png';
  String defaltbottoms = 'assets/images/slack.png';
  int mycoin = 2000;
  bool bought = false;
  List<Map<String, dynamic>> myitems = [
    {
      "coat": [
        {
          "price": 200,
          "name": "자켓",
          "image": "assets/images/jacket.png",
          "purchase": "false"
        }
      ],
      "top": [
        {
          "price": 100,
          "name": "반팔",
          "image": "assets/images/polo-shirt.png",
          "purchase": "false"
        }
      ],
      "bottoms": [
        {
          "price": 100,
          "name": "슬랙스",
          "image": "assets/images/slack.png",
          "purchase": "false"
        }
      ]
    }
  ];

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting();

    daysFormat = DateFormat.MMMMd('ko').add_jm();
    daysFormat2 = DateFormat('', 'ko').add_jm();

    dataLoad();
  }

  Future<CurrentWeather> getCurrentWeather(
      double latitude, double longitude) async {
    var key = FlutterConfig.get('apiKey');

    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$key&units=metric&lang=kr"));
    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<DailyWeather> getDailyWeather(
      double latitude, double longitude) async {
    var key = FlutterConfig.get('apiKey');
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,alerts&lang=kr&appid=$key"));
    if (response.statusCode == 200) {
      return DailyWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<void> getWeatherData() async {
    data = await getCurrentWeather(latitude, longitude);
    update();
  }

  Future<void> getDailyData() async {
    data2 = await getDailyWeather(latitude, longitude);
    update();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> getClothes() async {
    int temp = data!.main.temp.round();
    int index = 0;
    if (temp >= 28) {
      index = 0;
    } else if (temp >= 23) {
      index = 1;
    } else if (temp >= 20) {
      index = 2;
    } else if (temp >= 17) {
      index = 3;
    } else if (temp >= 12) {
      index = 4;
    } else if (temp >= 9) {
      index = 5;
    } else if (temp >= 5) {
      index = 6;
    } else {
      index = 7;
    }
    Map<String, dynamic> clotheindex = clothes[index]['clothes'];
    top = await clotheindex['top'][random.nextInt(clotheindex['top'].length)];
    bottoms = await clotheindex['bottoms']
        [random.nextInt(clotheindex['bottoms'].length)];
    update();
  }

  Future<void> dataLoad() async {
    await getCurrentLocation();
    await getWeatherData();
    await getDailyData();
    getClothes();
  }

  void changeTabIndex(int index) {
    tabindex = index;
    update();
  }

  void openDialog(
      String image, String name, int price, int index, String part) {
    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        buttonPadding: null,
        backgroundColor: Colors.white.withOpacity(0.9),
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 225,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 140,
                  child: Image(
                    image: AssetImage(image),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Image(
                    image: AssetImage('assets/images/coin.png'),
                    width: 14,
                  )
                ],
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        actions: [
          TextButton(
              child: const Text(
                "구매",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                buy(price, part, index);
                Get.back();
              }),
          TextButton(
            child: const Text(
              "취소",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  void changetopImage(String image) {
    defalttop = image;
    update();
  }

  void changebottomsImage(String image) {
    defaltbottoms = image;
    update();
  }

  void changeMytopImage(String image) {
    myroomdefalttop = image;
    update();
  }

  void changeMybottomsImage(String image) {
    myroomdefaltbottoms = image;
    update();
  }

  void changeMenuIndex(int index) {
    menuindex = index;
    update();
  }

  void changeMyroomMenuIndex(int index) {
    myroommenuindex = index;
    update();
  }

  void buy(int price, String part, int index) {
    var productmapidx = productmap[part][index];
    if (mycoin - price >= 0 && productmapidx['purchase'] == 'false') {
      mycoin -= price;
      productmapidx.update("purchase", (value) => 'true');
      myitems[0][part].add({
        'price': price,
        'name': productmapidx['name'].toString(),
        'image': productmapidx['image'].toString(),
        'purchase': productmapidx['purchase'].toString()
      });
    } else {
      print('error');
    }
    update();
  }
}
