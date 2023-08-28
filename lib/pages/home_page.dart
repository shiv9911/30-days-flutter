// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_application_1/models/catelog.dart';
import 'package:flutter_application_1/widgets/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  loadData() async {
    // await Future.delayed(Duration(seconds: 5));

    final catelogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decondeData = jsonDecode(catelogJson);
    var productData = decondeData["products"];

    CatelogModel.items =
        List.from(productData).map<Item>((item) => Item.fromMap(item)).toList();
    // await Future.delayed(Duration(seconds: 10));
    setState(() {});

    // print(productData);
  }

  @override
  Widget build(BuildContext context) {
    int days = 2;
    // final dummyList = List.generate(50, (index) => CatelogModel.items[0]);
    return Scaffold(
        backgroundColor: myTheme.creamColor,
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CatalogHeader(),
                if (CatelogModel.items != CatelogModel.items.isNotEmpty)
                  CatalogList().expand()
                else
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        )

        // (CatelogModel.items.isNotEmpty)
        //     ? GridView.builder(
        //         gridDelegate:
        //             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        //         itemBuilder: (context, index) {
        //           final item = CatelogModel.items[index];
        //           return Padding(
        //             padding: const EdgeInsets.all(20.0),
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10)),
        //               clipBehavior: Clip.antiAlias,
        //               child: InkResponse(
        //                 onTap: () {
        //                   print(item.name);
        //                 },
        //                 child: GridTile(
        //                   child: Image.network(item.image),
        //                   header: Center(child: Text(item.name)),
        //                   footer: Text(item.price.toString()),
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //         itemCount: CatelogModel.items.length,
        //       )
        //     // ? ListView.builder(
        //     //     itemCount: CatelogModel.items.length,
        //     //     itemBuilder: (context, index) {
        //     //       return itemWidgets(item: CatelogModel.items[index]);
        //     //     },
        //     //   )
        //     : const Center(child: CircularProgressIndicator()),
        // drawer: const myDrawer(),
        );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(myTheme.darkBluishColor).make(),
        "Trending Products".text.xl2.make()
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatelogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatelogModel.items[index];
        return CatalogItem(catalog: catalog);
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        CatalogImage(image: catalog.image),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg.color(myTheme.darkBluishColor).bold.make(),
            catalog.desc.text.textStyle(context.captionStyle).make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}".text.bold.xl.make(),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(myTheme.darkBluishColor),
                        shape: MaterialStateProperty.all(StadiumBorder())),
                    child: "Buy".text.make())
              ],
            ).pOnly(right: 8.0)
          ],
        ))
      ],
    )).white.rounded.square(150).make().py16();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;
  const CatalogImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .p8
        .color(myTheme.creamColor)
        .make()
        .p16()
        .w40(context);
  }
}
