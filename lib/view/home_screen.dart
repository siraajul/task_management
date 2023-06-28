import 'package:flutter/material.dart';

import '../model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e8e9),
      appBar: AppBar(
        title: const Text('Task Management'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          onLongPress: () {
            showBottomSheet(
              context: context,
              builder: (_) => Container(
                // height: 200,
                width: double.maxFinite,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Task Details',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Title: ${taskList[index].title}'),
                    Text('Description: ${taskList[index].description}'),
                    Text(
                        'Days Required: ${taskList[index].deadline?.toStringAsFixed(0)}'),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            taskList.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Delete')),
                  ],
                ),
              ),
            );
          },
          title: Text(taskList[index].title),
          subtitle: Text(taskList[index].description),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String? newTitle, newDescription, newDaysRequired;
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                            label: Text('Title'),
                          ),
                          onChanged: (value) {
                            newTitle = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Description',
                            label: Text('Description'),
                          ),
                          onChanged: (value) {
                            newDescription = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Days Required',
                            label: Text('Days Required'),
                          ),
                          onChanged: (value) {
                            newDaysRequired = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        try {
                          setState(() {
                            taskList.add(TaskModel(
                                title: newTitle!,
                                description: newDescription!,
                                deadline:
                                    double.parse(newDaysRequired ?? '0')));
                          });
                        } catch (e) {}
                        Navigator.pop(context);
                      },
                      child: const Text('Save'))
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
