import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app2/controller/hive_controller.dart';
import 'package:todo_app2/controller/todolist_controllers.dart';
import 'package:todo_app2/model/todo_model.dart';
import 'package:todo_app2/utils/colors/colors_contant.dart';
import 'package:todo_app2/views/widgets/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dbhive dbhive = Dbhive();

  //referance of hive box
  final _db = Hive.box('mytodo');

  @override
  void initState() {
    if (_db.get('TODOLIST') == null) {
      dbhive.intialData();
      print('initial');
    } else {
      dbhive.loaddata();
    }
    super.initState();
  }

  final titletextcontroller = TextEditingController();
  final decriptextcontroller = TextEditingController();
  final datetextcontroller = TextEditingController();

  DateTime date = DateTime.now();

  int seleectedIndex = 0;

  TodolistController todolistController = TodolistController();

  Color selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.scaffoldColor,
      appBar: AppBar(
        backgroundColor: ColorsConstant.appbarcolor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  //todo container
                  itemBuilder: (context, index) {
                    return TodoTile(
                      index: index,
                      onchanged: () {
                        setState(() {
                          todolistController.delete(index);
                        });
                      },
                      title: todolistController.mytodo[index].title
                          .toString()
                          .toUpperCase(),
                      decription: todolistController.mytodo[index].description,
                      date: todolistController.mytodo[index].date,
                      selectedColor: todolistController.mytodo[index].color,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  itemCount: todolistController.mytodo.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titletextcontroller.text = '';
          decriptextcontroller.text = '';
          datetextcontroller.text = '';
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      //textfield for title
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                        controller: titletextcontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      //textfield for description

                      child: TextField(
                        maxLines: 8,
                        controller: decriptextcontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      //textfield for date

                      child: TextField(
                        controller: datetextcontroller,
                        decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? newdate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900, 1, 1),
                                lastDate: DateTime(2100, 1, 1),
                              );
                              DateUtils.dateOnly(date);
                              if (newdate == null) {
                                return null;
                              } else {
                                datetextcontroller.text =
                                    newdate.toString().split(" ")[0];

                                date = DateTime(
                                    newdate.year, newdate.month, newdate.day);
                              }
                            },
                            icon: const Icon(
                              Icons.date_range_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),

                    // color picker for container
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ColorsConstant.color.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              selectedColor = ColorsConstant.color[index];
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: ColorsConstant.color[index],
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      )),
                                )),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //cancel button
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),

                        //save button
                        InkWell(
                          onTap: () {
                            setState(() {
                              todolistController.addata(
                                TodoModel(
                                    title: titletextcontroller.text,
                                    description: decriptextcontroller.text,
                                    date: datetextcontroller.text,
                                    color: selectedColor),
                              );
                            });

                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                                child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
