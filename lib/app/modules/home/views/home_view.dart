import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todoapp/app/constants/app_size_constants.dart';
import 'package:todoapp/app/constants/string_constants.dart';
import 'package:todoapp/app/data/models/task_model.dart';
import 'package:todoapp/app/modules/home/controllers/home_controller.dart';
import 'package:todoapp/app/modules/home/views/taskform_view.dart';
import 'package:todoapp/app/theme/theme.dart';
import 'package:todoapp/app/widgets/button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.HomeTitle,
            style: Get.textTheme.bodyText1SemiBold
                ?.copyWith(color: XColors.lightprimaryColor,fontSize: 22)),
        centerTitle: true,
        backgroundColor: XColors.primaryColor,
      ),
      body: Obx(() {
        return Column(
          children: [
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppString.searchTask,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) {
                      controller.searchTasks(value.trim());
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.sortTasks();
                },
                icon: Icon(Icons.sort_by_alpha_outlined),
              ),
            ]),
            gapH16,
            RoundButton(
              width: 260,
              title: AppString.addNewTask,
              textColor: XColors.lightprimaryColor,
              onPress: () {
                Get.to(() => TaskFormScreen());
              },
            ),
            gapH16,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.filteredTasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(task.description),
                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final result = await Get.to(
                                () => TaskFormScreen(task: task),
                              );
                              // If the user saved the task, update it in the controller
                              if (result != null) {
                                final updatedTask = TaskModel(
                                  title: result['title'],
                                  description: result['description'],
                                  id: task.id, // Maintain the same ID
                                );
                                controller.updateTask(updatedTask);
                              }
                            },
                          ),
                          Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              controller.toggleTaskStatus(
                                  task.id); // Use ID for status toggle
                            },
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete Task"),
                            content: Text(
                                "Are you sure you want to delete ${task.title}?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Delete"),
                                onPressed: () {
                                  controller.deleteTask(
                                      task.id); // Use ID for deletion
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
