import 'package:flutter/cupertino.dart';
import 'package:provider_todo/model/task.dart';

import '../data/database_helpaer.dart';

class MainProvider extends ChangeNotifier {
  int count = 0;
  late Task _task;
   TextEditingController? nameController;
   TextEditingController? dateController;

  void counter() {
    count++;
    notifyListeners();
  }

  void remover() {
    count--;
    notifyListeners();
  }

  void updateTaskList() {
  notifyListeners();
  }
  void updateTask() async {
    Task task = _task;

    Task currentTask = Task.withId(
      task.id,
      nameController!.text,
      "description1",
      DateTime.now(),
      dateController!.text,
      "19:00",
    );
    notifyListeners();
  }

  // void updateTask(TextEditingController _nameController, TextEditingController _dateController, Task currentTask, context) async {
  //   Task task = Task.withId(
  //     currentTask.id,
  //     _nameController.text,
  //     "description1",
  //     DateTime.now(),
  //     _dateController.text,
  //     "19:00",
  //   );
  //
  //   var res = await DatabaseHelper.intance.update(task);
  //   print("Updated task : $res");
  //   Navigator.pop(context);
  // }
}

