import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/constants/string_constants.dart';
import 'package:todoapp/app/data/models/task_model.dart';
import 'package:todoapp/app/modules/home/controllers/home_controller.dart';
import 'package:todoapp/app/theme/theme.dart';
import 'package:todoapp/app/widgets/button.dart';
import 'package:uuid/uuid.dart';

class TaskFormScreen extends GetView<HomeController> {
  final TaskModel? task;

  TaskFormScreen({this.task});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (task != null) {
      // If editing, pre-fill the form with existing task data
      _titleController.text = task!.title;
      _descriptionController.text = task!.description;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: XColors.primaryColor,
        title: Text(task == null ? AppString.addTask : AppString.EditTaskTitle,
            style: Get.textTheme.bodyText1SemiBold
                ?.copyWith(color: XColors.lightprimaryColor, fontSize: 22)),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: AppString.labelTask),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: AppString.labelDesc),
            ),
            SizedBox(height: 20),
            RoundButton(
              width: 200,
              title: task == null ? AppString.addTask : AppString.updateTask,
              textColor: XColors.lightprimaryColor,
              onPress: () {
                if (task == null) {
                  controller.addTask(TaskModel(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    id: Uuid().v4(),
                  ));
                  Get.back();
                } else if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  Get.back(result: {
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'id': task!.id,
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
