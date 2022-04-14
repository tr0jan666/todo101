import 'package:flutter/material.dart';
import 'package:todo101/config/app_config.dart';
import 'package:todo101/naviagator/states/app_route_state.dart';
import 'package:todo101/share/custom_button_widget.dart';

class UnknownScreenPage extends Page {
  const UnknownScreenPage() : super();
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (ctx) =>const UnknownScreen(),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: AppConfig.splashConfig.decoration != null
                ? AppConfig.splashConfig.decoration?.call(context)
                : BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Page Not Found"),
                const SizedBox(
                  height: 44,
                ),
                Text(
                  "404",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 44,
                ),
                SizedBox(
                  width: 128,
                  child: CustomButton(
                    title: "Back to home",
                    onPressed: () {
                      final path = NavigatorPathParams(pathSegments: ["/"]);
                      AppNavigation.replace(path, removeHistory: true);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}