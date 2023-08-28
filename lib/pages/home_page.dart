// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalog_header.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalog_list.dart';
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
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
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
