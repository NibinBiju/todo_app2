import 'package:flutter/material.dart';
import 'package:todo_app2/controller/todolist_controllers.dart';
import 'package:todo_app2/model/todo_model.dart';
import 'package:todo_app2/views/decription.dart';

class TodoTile extends StatelessWidget {
  TodoTile(
      {super.key,
      required this.index,
      required this.onchanged,
      required this.title,
      required this.decription,
      required this.date,
      this.selectedColor});

  final int index;
  final VoidCallback onchanged;
  final TodolistController todolistController = TodolistController();
  final String title;
  final String decription;
  final String date;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Decription(
              title: TodoModel.mytodo[index].title,
              decription: TodoModel.mytodo[index].description,
              date: TodoModel.mytodo[index].date,
            );
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 200,
        decoration: BoxDecoration(
          color: selectedColor ?? Colors.red,
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      //description
                      child: Text(
                        decription,
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
                //delete
                IconButton(
                  onPressed: onchanged,
                  icon: const Icon(
                    Icons.delete,
                    size: 34,
                  ),
                  iconSize: 28,
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
