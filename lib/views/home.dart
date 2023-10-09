import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app2/controller/hive_controller.dart';
import 'package:todo_app2/controller/todolist_controllers.dart';
import 'package:todo_app2/model/todo_model.dart';
import 'package:todo_app2/utils/colors/colors_contant.dart';
import 'package:todo_app2/views/widgets/color_picker.dart';
import 'package:todo_app2/views/widgets/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //instance for dbhive class
  Dbhive dbhive = Dbhive();
  final _db = Hive.box('mytodo');

  @override
  void initState() {
    dbhive.loadData();
    if (_db.get('mytodo') == null) {
      print('empty');
    } else {
      dbhive.loadData();
    }

    super.initState();
  }

  //controllers for textfield
  final titletextcontroller = TextEditingController();
  final decriptextcontroller = TextEditingController();
  final datetextcontroller = TextEditingController();

  //instance for datetime
  DateTime date = DateTime.now();

  int selectedIndex = 0;

  //instance for todocontroller class
  TodolistController todolistController = TodolistController();

  //variable for container color
  Color selectedColor = Colors.white;

  bool border = false;

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
                  color: Colors.purple.shade200,
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
                          fontSize: 28,
                        ),
                        controller: titletextcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none, labelText: 'Title'),
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
                        style: const TextStyle(
                          fontSize: 23,
                        ),
                        maxLines: 4,
                        controller: decriptextcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none, labelText: 'Description'),
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
                          labelText: 'Date',
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
                          return StatefulBuilder(
                            builder: (context, setState) => ColorPicker(
                              index: index,
                              selectedIndex: selectedIndex,
                              onchangeBorder: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedColor = ColorsConstant.color[index];
                                });
                              },
                            ),
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
                                  color: selectedColor,
                                ),
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
