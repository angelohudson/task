import 'package:task/page/list_task/input_justificativa.dart';
import 'package:task/service/http/task.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:task/model/task.dart';
import 'package:task/page/screen/alert.dart';

class ItemScreen extends StatefulWidget {
  final Task _task;
  final Future<bool> Function(int id, String just) _onRemove;

  ItemScreen(this._task, this._onRemove);

  @override
  State<StatefulWidget> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.widget._task.id.toString()),
      child: new InkWell(
        onTap: () => showCustomDialog(
          context,
          this.widget._task.taskname,
          this.widget._task.describe,
          this.widget._task.status,
          this._onConfirm,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 90.0,
            child: Material(
              color: this.widget._task.taskStatus == TaskStatus.CONFIRMADO ? Colors.indigo[50] : Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              shadowColor: Color(0x802196F3),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 5.0,
                      color: this.widget._task.status,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Text(
                                  this.widget._task.taskname,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Text(
                                  this.widget._task.subtask,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: this.widget._task.taskStatus == TaskStatus.CONFIRMADO
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Text(
                                  DateFormat("dd/MM hh:mm a")
                                      .format(this.widget._task.tasktime),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: this.widget._task.taskStatus == TaskStatus.CONFIRMADO,
                        onChanged: (val) {
                          this._onConfirm();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        List<dynamic> justificado = await imputJustificativa(context);
        if (justificado == null) return false;
        if (justificado[0])
          return this.widget._onRemove(this.widget._task.id, justificado[1]);
        return false;
      },
    );
  }

  void _onConfirm() {
    this._taskService.confirmTask(this.widget._task).then((ok) {
      if (ok) {
        setState(() {
          this.widget._task.taskStatus = TaskStatus.CONFIRMADO;
        });
      } else {
        showCustomDialog(
          context,
          "Erro ao deletar!",
          "Verifique sua conexão ou contate ao administrador.",
          Colors.red,
          () => print("Confirmado"),
        );
      }
    });
  }
}
