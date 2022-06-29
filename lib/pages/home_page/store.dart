import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/controller.dart';
import 'package:weatherapp/data/product.dart';

class Store extends StatelessWidget {
  const Store({Key? key}) : super(key: key);

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
                                child: Image(
                                  image: AssetImage(_.defalttop),
                                ),
                              ),
                              Expanded(
                                child: Image(
                                  image: AssetImage(_.defaltbottoms),
                                ),
                              ),
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
                            product('외투', 0),
                            product('상의', 1),
                            product('하의', 2),
                            product('기타', 3),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IndexedStack(
                          index: _.menuindex,
                          children: [
                            productList('coat'),
                            productList('top'),
                            productList('bottoms'),
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

Widget product(String part, int index) {
  final _ = Get.find<HomeController>();
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            _.menuindex == index ? Colors.transparent.withOpacity(0.2) : null,
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
      _.changeMenuIndex(index);
    },
  );
}

Widget productList(String part) {
  final _ = Get.find<HomeController>();
  return GridView.builder(
    shrinkWrap: true,
    itemCount: _.clothes2[0][part].length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1 / 1,
      mainAxisSpacing: 30,
      crossAxisSpacing: 30,
    ),
    itemBuilder: (context, index) {
      return Column(children: [
        InkWell(
          child: productmap[part][index]['purchase'] == 'true'
              ? Opacity(
                  opacity: 0.3,
                  child: Image(
                    image: AssetImage(_.clothes2[0][part][index]['image']),
                  ),
                )
              : Image(
                  image: AssetImage(_.clothes2[0][part][index]['image']),
                ),
          onTap: () {
            part != 'bottoms'
                ? _.changetopImage(_.clothes2[0][part][index]['image'])
                : _.changebottomsImage(_.clothes2[0][part][index]['image']);
            productmap[part][index]['purchase'] == 'false'
                ? _.openDialog(
                    _.clothes2[0][part][index]['image'],
                    _.clothes2[0][part][index]['name'],
                    _.clothes2[0][part][index]['price'],
                    index,
                    part)
                : null;
          },
        ),
      ]);
    },
  );
}
