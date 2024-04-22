import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_2/core/app_theme/theme_controller.dart';
import 'package:task_2/core/values/colors.dart';
import 'package:task_2/data/models/task.dart';
import 'package:task_2/modules/home/controller.dart';
import 'package:task_2/modules/home/widgets/add_card.dart';
import 'package:task_2/modules/home/widgets/add_dialog.dart';
import 'package:task_2/modules/home/widgets/task_card.dart';
import 'package:task_2/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      final currentThemeMode = themeController.currentTheme.value;

      // Define the SystemUiOverlayStyle based on the theme mode
      SystemUiOverlayStyle systemUiOverlayStyle =
          currentThemeMode == ThemeMode.dark
              ? SystemUiOverlayStyle.light // Light mode: Dark icons
              : SystemUiOverlayStyle.dark; // Dark mode: Light icons

      // Apply the systemUiOverlayStyle
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      
      return Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text('My Todo List'),
                    actions: [
                      Obx(
                        () => Switch(
                          value: themeController.currentTheme.value ==
                              ThemeMode.light,
                          onChanged: (value) {
                            themeController.toggleTheme();
                            Get.changeThemeMode(
                                themeController.currentTheme.value);
                          },
                          activeColor: darkGreen,
                        ),
                      )
                    ],
                    floating: true,
                    snap: true,
                    pinned: true,
                    expandedHeight: 100.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(),
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount: 2,
                    children: [
                      ...controller.tasks
                          .map((element) => LongPressDraggable<Task>(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (velocity, offset) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (details) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.5,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element),
                              )),
                      AddCard(),
                    ],
                  ),
                ],
              ),
              ReportPage(),
            ],
          ),
        ),
        floatingActionButton: DragTarget<Task>(
          builder: (_, __, ____) {
            return Obx(
              () => FloatingActionButton(
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showInfo('Please create task first..');
                  }
                },
                backgroundColor:
                    controller.deleting.value ? Colors.red : darkGreen,
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add),
              ),
            );
          },
          onAccept: (Task task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Deleted');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Icon(Icons.data_usage),
              )
            ],
          ),
        ),
      );
    });
  }
}
