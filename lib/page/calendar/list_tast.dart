import 'package:task/page/screen/alert.dart';
import 'package:task/page/screen/load.dart';
import 'package:task/service/http/task.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:task/model/task.dart';
import 'package:task/page/calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class TasksCalendar extends StatefulWidget {
  final String title;

  TasksCalendar({Key key, this.title}) : super(key: key);

  @override
  _TasksCalendarState createState() => _TasksCalendarState();
}

class _TasksCalendarState extends State<TasksCalendar>
    with TickerProviderStateMixin {
  final TaskService _webClient = TaskService();
  Map<String, Map<int, Task>> _events;
  Map<int, Task> _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  bool _isLoad = true;
  DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    this._events = Map();
    this._currentDate = DateTime.now();

    this._resetBaseByCurrentMonth();

    _selectedEvents = Map();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  void _resetBaseByCurrentMonth() {
    var now = new DateTime.now();
    var firstDayDateTime = new DateTime(now.year, now.month, 1);
    var lastDayDateTime = (now.month < 12)
        ? new DateTime(now.year, now.month + 1, 0)
        : new DateTime(now.year + 1, 1, 0);
    this._resetBaseDate(firstDayDateTime, lastDayDateTime);
  }

  void _resetBaseDate(DateTime firstDayDateTime, DateTime lastDayDateTime) {
    this._webClient.findAll().then(
          (tasksResponse) => {
            setState(() {
              tasksResponse.forEach((val) {
                String date = DateFormat("yyyy-MM-dd").format(val.tasktime);
                if (this._events[date] == null) {
                  _events[date] = Map();
                }
                this._events[date][val.id] = (val);
              });
              this._isLoad = false;
            }),
          },
        );
  }

  void _onDaySelected(DateTime day, List<dynamic> events, List<dynamic> a) {
    this._selectedEvents = Map();
    this._currentDate = day;
    setState(() {
      events.forEach((task) => this._selectedEvents[task.id] = task);
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    this._resetBaseDate(first, last);
  }

  @override
  Widget build(BuildContext context) {
    if (this._isLoad) {
      return LoadScreen();
    } else {
      return ListView(
        children: <Widget>[
          Calendar(
            this._onVisibleDaysChanged,
            this._onDaySelected,
            this._events,
            this._selectedEvents,
            this._calendarController,
            this._onRemoveItem,
          ),
        ],
      );
    }
  }

  Future<bool> _onRemoveItem(int id, String just) async {
    bool ok = await this._webClient.cancelTask(this._selectedEvents[id], just);
    if (ok) {
      setState(() {
        this._selectedEvents.remove(id);
        this
            ._events[DateFormat("yyyy-MM-dd").format(this._currentDate)]
            .remove(id);
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
    return ok;
  }
}
