import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_2/core/utils/extensions.dart';
import 'package:task_2/modules/home/controller.dart';

class TodoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.wp),
            child: Image.asset(
              'assets/image/task.png',
              fit: BoxFit.cover,
              width: 60.0.wp,
            ),
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0.wp,
                  vertical: 1.0.wp,
                ),
                child: Text(
                  'Todo(${homeCtrl.doingTodos.length})',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.doingTodos
                  .map(
                    (element) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0.wp,
                        vertical: 3.0.wp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey),
                              value: element['done'],
                              onChanged: (value) {
                                homeCtrl.doneTodo(element['title']);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 65),
                              child: Text(
                                element['title'],
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ));
  }
}
