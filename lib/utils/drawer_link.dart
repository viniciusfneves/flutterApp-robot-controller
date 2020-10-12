import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerLink extends StatelessWidget {
  @required
  final IconData icon;
  @required
  final String title;
  final String pageRoute;
  final trailing;

  const DrawerLink(
      {Key key, this.icon, this.title, this.pageRoute, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () async =>
              {await Navigator.pushNamed(context, this.pageRoute)},
          leading: Icon(
            this.icon,
            size: 28,
          ),
          title: Text(
            this.title,
            style: TextStyle(fontSize: 16, fontFamily: 'roboto'),
          ),
          trailing: this.trailing,
        ),
        Divider()
      ],
    );
  }
}
