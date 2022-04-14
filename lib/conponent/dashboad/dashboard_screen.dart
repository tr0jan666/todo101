import 'package:flutter/material.dart';
import 'package:todo101/config/app_module.dart';
import 'package:todo101/conponent/dashboad/detail_layout.dart';
import 'package:todo101/conponent/dashboad/layout_left.dart';
import 'package:todo101/conponent/dashboad/suggestion_layout.dart';
import 'package:todo101/share/layout/response.dart';

final dashboadModel = AppModule(
    key: "dashboadKeyAction", page: DashboardScreenPage(), path: "dashboad");

class DashboardScreenPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => const DashBoadScreen());
  }
}

class DashBoadScreen extends StatefulWidget {
  const DashBoadScreen({Key? key}) : super(key: key);

  @override
  _DashBoadScreenState createState() => _DashBoadScreenState();
}

class _DashBoadScreenState extends State<DashBoadScreen> {
  ViewMode _viewMode = ViewMode.none;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: Responsive.isDesktop(context) ? 2 : 1,
            child: const LayoutLeft()),
        const Divider(
          color: Color.fromARGB(255, 129, 128, 128),
        ),
        if (Responsive.isDesktop(context))
          Expanded(
              flex: 8,
              child: DetailLayout(
                iconTopAction: () {
                  setState(() {
                    _viewMode = ViewMode.suggestion;
                  });
                },
              )),
        if (Responsive.isDesktop(context) && _viewMode == ViewMode.none)
          Container(),
        if (Responsive.isDesktop(context) && _viewMode == ViewMode.suggestion)
          Expanded(
            flex: 2,
            child: SugeetionLayout(
            onBack: () {
              setState(() {
                _viewMode = ViewMode.none;
              });
            },
          ))
      ],
    );
  }
}

enum ViewMode { suggestion, none }
