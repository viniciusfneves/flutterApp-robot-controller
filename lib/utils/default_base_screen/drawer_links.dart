import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerLink extends StatelessWidget {
  @required
  final IconData icon;
  @required
  final String title;
  final String pageRoute;

  const DrawerLink({Key key, this.icon, this.title, this.pageRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, this.pageRoute),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  this.icon,
                  size: 22,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  this.title,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
