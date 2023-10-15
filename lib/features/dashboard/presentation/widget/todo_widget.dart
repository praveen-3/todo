import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:todo_flutter/core/res/dimens.dart';
import 'package:todo_flutter/features/dashboard/data/entities/todo_entity.dart';
import 'package:todo_flutter/features/dashboard/presentation/change_notifier_properties/dashboard_change_notifier_properties.dart';
import 'package:todo_flutter/features/dashboard/presentation/enums/todo_status.dart';
import 'package:todo_flutter/features/dashboard/presentation/view_models/dashboard_viewmodel.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget(this.todoEntity, {super.key});
  final TodoEntity todoEntity;
  @override
  Widget build(BuildContext context) {
    var viewModel =
        PropertyChangeProvider.of<DashboardViewModel, DashboardProperties>(
                context,
                listen: false)!
            .value;
    Size size = MediaQuery.of(context).size;
    final DateTime createdDate = todoEntity.createdAt!;
    final String createdDateFormatted =
        DateFormat("d MMM yyyy").format(createdDate);
    final DateTime updatedDate = todoEntity.updatedAt!;
    final String updatedDateFormatted =
        DateFormat("d MMM yyyy").format(updatedDate);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  todoEntity.title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Visibility(
                  visible: !(todoEntity.status == ToDoStatus.DONE),
                  child: IconButton(
                      onPressed: () {
                        viewModel.updateTodoStatus(todoEntity.id!);
                      },
                      icon: const Icon(
                        Iconsax.tick_circle,
                        color: Color.fromARGB(255, 189, 188, 188),
                      )),
                ),
                IconButton(
                  onPressed: () {
                    viewModel.deleteTodo(todoEntity.id!);
                  },
                  icon: const Icon(
                    Iconsax.trash,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimens.dimen_10,
            ),
            Row(
              children: [
                const Icon(
                  Iconsax.calendar_1,
                  size: 13,
                  color: Colors.grey,
                ),
                Text(
                  !(todoEntity.status == ToDoStatus.DONE)
                      ? 'Created On : '
                      : "Completed On : ",
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  !(todoEntity.status == ToDoStatus.DONE)
                      ? createdDateFormatted
                      : updatedDateFormatted,
                )
              ],
            ),
            Theme(
              data: ThemeData(dividerColor: Colors.transparent),
              child: ExpansionTile(
                expandedAlignment: Alignment.topLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Description',
                  style: TextStyle(fontSize: 13),
                ),
                children: [
                  Text(todoEntity.description),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
