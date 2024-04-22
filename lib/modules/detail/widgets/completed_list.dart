import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_2/core/utils/extensions.dart';
import 'package:task_2/modules/home/controller.dart';

class CompletedList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  CompletedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0.wp,
                    vertical: 1.0.wp,
                  ),
                  child: Text(
                    'Completed(${homeCtrl.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map((element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                          background: Container(
                            color: Colors.red.withOpacity(0.8),
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.0.wp),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.0.wp,
                              vertical: .5.wp,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.blue,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.wp),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 70),
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
                        ))
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
