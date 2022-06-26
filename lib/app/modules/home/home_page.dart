import 'package:flutter/material.dart';
import 'package:task/app/modules/home/components/calendar/list_tast.dart';
import 'package:task/app/modules/home/components/list_task/list_task.dart';
import 'package:task/app/modules/home/model/home_item_tamplate.dart';
import 'package:task/app/modules/home/components/navegation_screen.dart';
import 'package:task/app/modules/home/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = new ListPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: NavegationScreen(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.cyan[400],
                    ],
                    begin: const FractionalOffset(0.2, 0.2),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                padding: EdgeInsets.only(top: 80),
                child: Align(
                  alignment: Alignment.center,
                  child: screenView,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = ListPage();
        });
      } else if (drawerIndex == DrawerIndex.CALENDARIO) {
        setState(() {
          screenView = TasksCalendar();
        });
      }
    }
  }
}
