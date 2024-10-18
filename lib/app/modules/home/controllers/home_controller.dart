import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/app/data/models/task_model.dart';

class HomeController extends GetxController {
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TaskModel> filteredTasks = <TaskModel>[].obs; // Change to RxList
  RxBool isTaskSorted = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  // Add new task
  void addTask(TaskModel task) {
    tasks.add(task);
    _updateFilteredTasks(); // Update filtered tasks
    saveTasks();
  }

  // Update an existing task
  void updateTask(TaskModel updatedTask) {
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask.copyWith(id: updatedTask.id); // Maintain the original ID
      saveTasks();
      _updateFilteredTasks(); // Update filtered tasks
    }
  }

  // Search and filter tasks
  void searchTasks(String query) {
    searchQuery.value = query; // Store the query
    _updateFilteredTasks(); // Update filtered tasks based on the current query
  }

  // Update filtered tasks based on search and sort
  void _updateFilteredTasks() {
    if (searchQuery.value.isEmpty) {
      filteredTasks.value = tasks; // Show all tasks if no search query
    } else {
      filteredTasks.value = tasks.where((task) {
        return task.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  // Sort tasks
  void sortTasks() {
    isTaskSorted.value = !isTaskSorted.value; // Toggle the sort state
    if (isTaskSorted.value) {
      filteredTasks.sort((a, b) => a.isCompleted ? 1 : -1);
    } else {
      filteredTasks.sort((a, b) => b.isCompleted ? 1 : -1);
    }
  }

  // Delete a task
  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id); // Remove task by ID
    _updateFilteredTasks(); // Update filtered tasks
    saveTasks();
  }

  // Mark task as completed
  void toggleTaskStatus(String id) {
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(
        isCompleted: !tasks[index].isCompleted,
      );
      _updateFilteredTasks(); // Update filtered tasks
      saveTasks();
    }
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList = tasks.map((task) => jsonEncode(task.toMap())).toList();
    await prefs.setStringList('tasks', taskList);
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      tasks.assignAll(taskList.map((task) => TaskModel.fromMap(jsonDecode(task))).toList());
      _updateFilteredTasks(); // Initialize filtered tasks
    }
  }
}