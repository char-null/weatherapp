import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/controller.dart';
import 'package:weatherapp/pages/home_page/menu.dart';
import 'package:weatherapp/pages/home_page/myroom.dart';
import 'package:weatherapp/pages/home_page/store.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(HomeController());
    return GetBuilder<HomeController>(builder: (_) {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff8F93EA), Color(0xffFFAE88)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: IndexedStack(
            index: _.tabindex,
            children: [
              SafeArea(
                child: _.top != null
                    ? Center(
                        child: Column(
                          children: [
                            currentState(context),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return const VerticalDivider(
                                      color: Colors.transparent,
                                      width: 8,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.transparent.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 80,
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              _.daysFormat2.format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          (_
                                                                  .data2!
                                                                  .hourly[
                                                                      index + 1]
                                                                  .dt! *
                                                              1000),
                                                          isUtc: false)
                                                  .toLocal()),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${_.data2!.hourly[index + 1].temp.round()}˚',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/${_.data2!.hourly[index + 1].weather[0].icon}.png'),
                                                    width: 30,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.63,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.transparent.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            '추천 스타일',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Image(
                                              image: AssetImage(
                                                  '${_.top!.values.last}'),
                                            ),
                                          ),
                                          Expanded(
                                            child: Image(
                                              image: AssetImage(
                                                  '${_.bottoms!.values.last}'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       vertical: 10, horizontal: 15),
                                  //   width:
                                  //       MediaQuery.of(context).size.width * 0.2,
                                  //   decoration: BoxDecoration(
                                  //     color:
                                  //         Colors.transparent.withOpacity(0.2),
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: Column(
                                  //     children: [
                                  //       const Text(
                                  //         '필수',
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontWeight: FontWeight.w600),
                                  //       ),
                                  //       const SizedBox(
                                  //         height: 10,
                                  //       ),
                                  //       Container(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             vertical: 10, horizontal: 5),
                                  //         decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(10),
                                  //         ),
                                  //         child: Column(
                                  //           children: [
                                  //             Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.center,
                                  //               children: const [
                                  //                 Image(
                                  //                   width: 30,
                                  //                   image: AssetImage(
                                  //                       'assets/images/sunscreen.png'),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 20,
                                  //                 ),
                                  //                 Image(
                                  //                   width: 30,
                                  //                   image: AssetImage(
                                  //                       'assets/images/umbrella.png'),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 ),
                                  //                 Image(
                                  //                   width: 40,
                                  //                   image: AssetImage(
                                  //                       'assets/images/mask.png'),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : const Center(
                        child: RefreshProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: Colors.white,
                        ),
                      ),
              ),
              const MyRoom(),
              const Store(),
              const Menu(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueGrey.withOpacity(0),
            elevation: 0,
            selectedItemColor: Colors.white,
            currentIndex: _.tabindex,
            onTap: _.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.sun_min),
                label: '날씨',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: '마이룸',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart),
                label: '상점',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet),
                label: '메뉴',
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget currentState(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: GetBuilder<HomeController>(
      builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.16,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _.daysFormat.format(DateTime.now()),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _.data!.name.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text('${_.data!.main.temp.round()}˚',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center),
                        Image(
                          image: AssetImage(
                              'assets/images/${_.data!.weather[0].icon}.png'),
                          width: 35,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _.dataLoad();
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${_.data?.weather[0].description}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${_.data2!.daily[0].temp.max.round()}˚/${_.data2!.daily[0].temp.min.round()}˚',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '체감온도 ${_.data2!.current.feelsLike.round()}˚',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    ),
  );
}
