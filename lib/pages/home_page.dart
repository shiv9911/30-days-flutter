import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/catelog.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/item_widgets.dart';

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
    final catelogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decondeData = jsonDecode(catelogJson);
    var productData = decondeData["products"];
    // print(productData);
  }

  @override
  Widget build(BuildContext context) {
    int days = 2;
    final dummyList = List.generate(50, (index) => CatelogModel.items[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Catelog App"),
      ),
      body: ListView.builder(
        itemCount: dummyList.length,
        itemBuilder: (context, index) {
          return itemWidgets(item: dummyList[index]);
        },
      ),
      drawer: myDrawer(),
    );
  }
}
