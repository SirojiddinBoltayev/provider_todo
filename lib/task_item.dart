import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/database_helpaer.dart';
import 'model/model_pv.dart';
import 'model/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem(this.task, {Key? key}) : super(key: key);

  void updateTaskList(context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateTaskList();
  }

  void deletaeTask(context)async{
   await DatabaseHelper.intance.delete(task.id!);
   updateTaskList(context);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const  SizedBox(
          height: 12,
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: ListTile(
            title: Text(
              task.title ?? "...",
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(task.startTime ?? "..."),
            trailing: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child:const Text('Edit'),
                    onTap: () {print(task.id);},
                  ),
                 const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  )
                ];
              },
              onSelected: (String value) {

                 if(value == "delete"){
                  deletaeTask(context);
                }
              },
            ),
            leading: Container(
              height: 61.0,
              width: 61.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient:const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF9C2CF3),
                      Color(0xFF3A49F9),
                    ],
                  )),
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
