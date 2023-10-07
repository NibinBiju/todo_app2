import 'package:flutter/material.dart';
import 'package:todo_app2/utils/colors/colors_contant.dart';

class Decription extends StatelessWidget {
  const Decription(
      {super.key,
      required this.title,
      required this.decription,
      required this.date});

  final String title;
  final String decription;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 29,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Text(
                decription,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
