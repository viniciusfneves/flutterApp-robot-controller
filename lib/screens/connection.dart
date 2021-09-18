import 'package:blue_app/app_controller/app_routes.dart';
import 'package:blue_app/screens/screen_template/screen_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConectionPage extends StatefulWidget {
  @override
  _ConectionPageState createState() => _ConectionPageState();
}

class _ConectionPageState extends State<ConectionPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text('Em Desenvolvimento'),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                child: Text('Refresh'),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.Connection),
              ),
            )
          ],
        ),
      ),
    );
  }
}
