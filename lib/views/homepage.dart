import 'package:bible_alarm_app/constants/theme_data.dart';
import 'package:bible_alarm_app/data.dart';
import 'package:bible_alarm_app/enums.dart';
import 'package:bible_alarm_app/views/clockpage.dart';
import 'package:bible_alarm_app/views/clockview.dart';
import 'package:bible_alarm_app/menuinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((cMenuInfo) => buildMenuButton(cMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white60,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
            builder: (BuildContext context, MenuInfo value, Widget child) {
              if(value.menuType != MenuType.clock) {
                return Container();
              }
              return ClockPage();
            },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo cMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: cMenuInfo.menuType == value.menuType ?
            CustomColors.menuBackgroundColor: Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(cMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(cMenuInfo.imageSource, scale: 1.5),
              SizedBox(height: 16),
              Text(cMenuInfo.title ?? '',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.white,
                      fontSize: 14)),
            ],
          ),
        );
      },
    );
  }
}
