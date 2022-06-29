import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/controller.dart';

class MyRoom extends StatelessWidget {
  const MyRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (_) {
      return SafeArea(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        image: AssetImage('assets/images/coin.png'),
                        width: 14,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        _.mycoin.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '미리보기',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                  child: _.myroomdefalttop != ''
                                      ? Image(
                                          image: AssetImage(_.myroomdefalttop),
                                        )
                                      : Container()),
                              Expanded(
                                  child: _.myroomdefaltbottoms != ''
                                      ? Image(
                                          image:
                                              AssetImage(_.myroomdefaltbottoms),
                                        )
                                      : Container()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            item('외투', 0),
                            item('상의', 1),
                            item('하의', 2),
                            item('기타', 3),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IndexedStack(
                          index: _.myroommenuindex,
                          children: [
                            itemList('coat'),
                            itemList('top'),
                            itemList('bottoms'),
                            Center(
                                child: Text(
                              '준비중입니다',
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget item(String part, int index) {
  final _ = Get.find<HomeController>();
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _.myroommenuindex == index
            ? Colors.transparent.withOpacity(0.2)
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      child: Text(
        part,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    onTap: () {
      _.changeMyroomMenuIndex(index);
    },
  );
}

Widget itemList(String part) {
  final _ = Get.find<HomeController>();
  return GridView.builder(
    shrinkWrap: true,
    itemCount: _.myitems[0][part].length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1 / 1,
      mainAxisSpacing: 30,
      crossAxisSpacing: 30,
    ),
    itemBuilder: (context, index) {
      return Column(children: [
        InkWell(
          child: Image(
            image: AssetImage(_.myitems[0][part][index]['image']),
          ),
          onTap: () {
            part != 'bottoms'
                ? _.changeMytopImage(_.myitems[0][part][index]['image'])
                : _.changeMybottomsImage(_.myitems[0][part][index]['image']);
          },
        ),
      ]);
    },
  );
}
