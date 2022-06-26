import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task/app/modules/home/components/list_task/item_task_screen.dart';
import 'package:task/app/modules/home/model/task.dart';
import 'package:task/app/shared/components/load.dart';

class Calendar extends StatefulWidget {
  final Function _onDaySelected;
  final Map<String, Map<int, Task>> _events;
  final Map<int, Task> _selectedEvents;
  final CalendarController _calendarController;
  final Function _onVisibleDaysChanged;
  final Function _onRemove;

  Calendar(
    this._onVisibleDaysChanged,
    this._onDaySelected,
    this._events,
    this._selectedEvents,
    this._calendarController,
    this._onRemove,
  );

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: _buildTile(
            _buildTableCalendar(),
          ),
        ),
        const SizedBox(height: 8.0),
        _buildEventList(),
      ],
    );
  }

  Widget _buildTile(Widget child) {
    if (this.widget._events == null) {
      return LoadComponent();
    } else {
      return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(child: child),
      );
    }
  }

  Widget _buildTableCalendar() {
    Map<DateTime, List<Task>> events = Map();
    if (this.widget._events != null) {
      this.widget._events.forEach((key, value) {
        events[DateFormat("yyyy-MM-dd").parse(key)] = value.values.toList();
      });
    }
    return TableCalendar(
      locale: 'pt',
      calendarController: this.widget._calendarController,
      events: events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: this.widget._onDaySelected,
      onVisibleDaysChanged: this.widget._onVisibleDaysChanged,
    );
  }

  Widget _buildEventList() {
    List<Widget> list = this.widget._selectedEvents.values.map((event) {
      return new ItemTaskComponent(
        event,
        this._onRemove,
        active: !([TaskStatus.DELETADO, TaskStatus.CONCLUIDA]
            .contains(event.taskStatus)),
      );
    }).toList();
    return new Column(
      children: list,
    );
  }

  Future<bool> _onRemove(int id, String just) {
    return this.widget._onRemove(id, just);
  }
}
