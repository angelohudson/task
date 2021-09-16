import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/model/task.dart';

class TableSchedule extends StatelessWidget {
  final List<Task> tasks;

  TableSchedule(this.tasks);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text('Função'),
        ),
        DataColumn(
          label: Text('Membro'),
        ),
      ],
      rows: this
          .tasks
          .map((task) => DataRow(cells: [
                DataCell(Text(task.function == null ? "" : task.function)),
                DataCell(Text(task.memberName == null ? "" : task.memberName)),
              ]))
          .toList(),
    );
  }
}
