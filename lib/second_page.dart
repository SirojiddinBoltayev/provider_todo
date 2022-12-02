
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo/data/database_helpaer.dart';
import 'package:provider_todo/home_page.dart';
import 'package:provider_todo/model/model_pv.dart';
import 'package:provider_todo/task_item.dart';

import 'model/task.dart';

class SecondPage extends StatefulWidget {
  TextEditingController nameController;
  TextEditingController dateController;

  SecondPage({
    Key? key,
    required this.dateController,
    required this.nameController,
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Task? task;

  void updateTaskList(context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateTaskList();
  }

  void deletaeTask(context) async {
    await DatabaseHelper.intance.delete(task!.id!);
    updateTaskList(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
        leading: IconButton(
          onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage()));},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              context.watch<MainProvider>().count.toString(),
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: FutureBuilder(
          future: DatabaseHelper.intance.getTasks(),
          builder: (BuildContext context, AsyncSnapshot<List<Task?>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return snapshot.data![index] == null
                      ? Container()
                      : TaskItem(snapshot.data!.reversed.toList()[index]!);

                  //   ListTile(
                  //   title: Text(snapshot.data![index].title.toString()),
                  //   subtitle: Text(snapshot.data![index].description.toString()),
                  //   leading: Icon(Icons.task_alt_sharp,color: Colors.greenAccent,),
                  //   onTap: (){},
                  //   trailing:
                  //   PopupMenuButton(
                  //     itemBuilder: (context) {
                  //       return [
                  //         PopupMenuItem(
                  //           value: 'edit',
                  //           child:const Text('Edit'),
                  //           onTap: () {},
                  //         ),
                  //         const PopupMenuItem(
                  //           value: 'delete',
                  //           child: Text('Delete'),
                  //         )
                  //       ];
                  //     },
                  //     // onSelected: (String value) {
                  //     //   if (value == 'edit') {
                  //     //     Navigator.of(context)
                  //     //         .push(MaterialPageRoute(
                  //     //       builder: (context) => CreateTaskPage(currentTask: task),
                  //     //     ))
                  //     //         .then((value) => updateTaskList(context));
                  //     //   }
                  //     //   else if(value == "delete"){
                  //     //     // deletaeTask(context);
                  //     //   }
                  //     // },
                  //   ),
                  //
                  // );
                });
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "buttonThree",
            onPressed: () {
              viewModel.counter();
            },
            child: Icon(
              Icons.add,
              color: Colors.greenAccent,
            ),
          ),
          FloatingActionButton(
            heroTag: "buttonFour",
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
// Widget tasksList() {
//   return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.8,
//       child: Consumer<MainProvider>(builder: (context, data, child) {
//         return FutureBuilder(
//             future: DatabaseHelper.instance.getTasks(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
//               return ListView.builder(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 itemBuilder: (context, index) {
//                   return ;
//                 },
//                 itemCount: snapshot.data?.length ?? 0,
//               );
//             });
//       }));
// }
}
