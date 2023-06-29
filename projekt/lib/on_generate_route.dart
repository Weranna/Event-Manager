import 'package:flutter/material.dart';
import 'package:projekt/const.dart';
import 'package:projekt/features/presentation/pages/add_event_page.dart';

import 'package:projekt/features/presentation/pages/google_map_page.dart';
import 'package:projekt/features/presentation/pages/login_page.dart';

import 'package:projekt/features/presentation/pages/my_events_page.dart';
import 'package:projekt/features/presentation/pages/register_page.dart';
import 'package:projekt/features/presentation/pages/single_event_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments as Map;
    switch (settings.name) {
      case PageConst.googleMapPage:
        {
          if (args is Map) {
            return materialBuilder(
                widget: GoogleMapPage(
              coordinates: args['coordinates'],
            ));
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.singleEventPage:
        {
          if (args is Map) {
            return materialBuilder(
                widget: SingleEventPage(
              eventId: args['eventId'],
              uid: args['uid'],
            ));
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.myEventsPage:
        {
          if (args is Map) {
            return materialBuilder(
                widget: MyEventsPage(
              uid: args['uid'],
            ));
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }

      case PageConst.addEventPage:
        {
          if (args is Map) {
            return materialBuilder(
                widget: AddEventPage(
              uid: args['uid'],
            ));
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.registerPage:
        {
          return materialBuilder(widget: const RegisterPage());
        }
      case PageConst.loginPage:
        {
          return materialBuilder(widget: const LoginPage());
        }
      case "/":
        {
          return materialBuilder(widget: const LoginPage());
        }

      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Error Page"),
        ),
        body: const Center(
          child: Text("Error Page"),
        ));
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
