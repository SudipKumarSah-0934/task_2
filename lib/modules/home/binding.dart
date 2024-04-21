import 'package:get/get.dart';
import 'package:task_2/data/provider/task/provider.dart';
import 'package:task_2/data/services/storage/repository.dart';
import 'package:task_2/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
