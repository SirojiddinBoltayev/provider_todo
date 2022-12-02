import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/data/database_helpaer.dart';
import 'package:provider_todo/second_page.dart';
import 'package:provider_todo/model/model_pv.dart';

import 'model/task.dart';

class MyHomePage extends StatefulWidget {
  Task? task;

  MyHomePage({this.task, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String hour =
      "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";

  void updateTask() async {}
  bool onpressed = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainProvider>(context);

    // Widget createButton() {
    //   return
    // }

    Widget form() {
      return Column(
        children: [
          TextFormField(
            controller: nameController,
            style: const TextStyle(color: Colors.white, fontSize: 30),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.white, fontSize: 20, letterSpacing: 3),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          TextFormField(
            controller: dateController,
            style: const TextStyle(color: Colors.white, fontSize: 30),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: "Date",
              fillColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.white, fontSize: 20, letterSpacing: 3),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xff3A49F9),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff9C2CF3), Color(0xff3A49F9)],
                      begin: const FractionalOffset(1.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 64,
                          ),
                          Text(
                            widget.task == null
                                ? 'Create a Task'
                                : 'Update a task',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 64,
                          ),
                          const Icon(
                            Icons.search,
                            size: 32,
                            color: Colors.white,
                          )
                        ],
                      ),
                      form()
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 26,
                      ),
                      const Text(
                        "Description",
                        style:
                            TextStyle(color: Color(0xffBFC8E8), fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, "
                        "er adipiscing elit, sed dianummy "
                        "nibh euismod dolor sit amet, er adipiscing elit, "
                        "sed dianummy nibh euismod.",
                        style: TextStyle(
                            color: Color(0xff2E3A59),
                            fontSize: 20,
                            height: 1.2),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      const Text(
                        "Category",
                        style:
                            TextStyle(color: Color(0xffBFC8E8), fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff9C2CF3),
                                    Color(0xff3A49F9)
                                  ],
                                  begin: FractionalOffset(1.0, 0.0),
                                  end: FractionalOffset(1.0, 1.0),
                                  tileMode: TileMode.clamp),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: TextButton(
                            onPressed: () {
                              if (nameController.text != "" &&
                                  dateController.text != "") {
                                createTask();
                                updateTask();
                                setState(() {
                                  onpressed = true;
                                });
                                // _initTimer(Widget child){
                                Timer(const Duration(seconds: 1), () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SecondPage(
                                        dateController: dateController,
                                        nameController: nameController,
                                      ),
                                    ),
                                  );
                                });
                              }
                            },

                            // },
                            child: Center(
                              child: onpressed == true
                                  ? CircularProgressIndicator()
                                  : Text(
                                      widget.task == null
                                          ? 'Create task'
                                          : 'Update task',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                            ),
                          )),
                      // createButton(),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "buttonOne",
            onPressed: () {
              viewModel.counter();
            },
            child: Icon(
              Icons.add,
              color: Colors.greenAccent,
            ),
          ),
          FloatingActionButton(
            heroTag: "buttonTwo",
            onPressed: () {
              viewModel.remover();
            },
            child: Icon(
              Icons.remove,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  void createTask() {
    Task newTask = Task(nameController.text, dateController.text,
        DateTime.now(), hour, "16:13");

    var res = DatabaseHelper.intance.insert(newTask);
    print(res);
  }
}
