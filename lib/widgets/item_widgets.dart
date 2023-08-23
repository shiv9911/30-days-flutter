import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catelog.dart';

class itemWidgets extends StatelessWidget {
  final Item item;

  const itemWidgets({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("Item ${item.name} pressed.");
        },
        leading: Image.network(
          item.image,
          fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Appropriate logging or analytics, e.g.
            // myAnalytics.recordError(
            //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
            //   exception,
            //   stackTrace,
            // );
            return const Text('ð¢');
          },
        ),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text("\$${item.price}",
            textScaleFactor: 1.5,
            style: const TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
