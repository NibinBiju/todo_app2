import 'package:flutter/material.dart';
import 'package:todo_app2/controller/todolist_controllers.dart';
import 'package:todo_app2/model/todo_model.dart';
import 'package:todo_app2/views/decription.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.index,
    required this.onchanged,
    required this.title,
    required this.description,
    required this.date,
    this.selectedColor,
    required this.selectedIndex,
  });

  final int index;
  final VoidCallback onchanged;
  final TodolistController todolistController = TodolistController();
  final String title;
  final String description;
  final String date;
  final Color? selectedColor;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Decription(
                title: title,
                decription: description,
                date: date,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 200,
        decoration: BoxDecoration(
          color:
              selectedIndex == index ? selectedColor : Colors.purple.shade300,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    SizedBox(
                      width: 130,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      //description
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //share button
                    IconButton(
                        onPressed: () {
                          todolistController.shareData(TodoModel(
                              title: title,
                              description: description,
                              date: date));
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 31,
                        )),

                    //delete
                    IconButton(
                      onPressed: onchanged,
                      icon: const Icon(
                        Icons.delete,
                        size: 34,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  //date
                  date,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
