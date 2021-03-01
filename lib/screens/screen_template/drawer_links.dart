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
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 18),
            title: Text(
              this.title,
              style: TextStyle(fontSize: 15),
            ),
            leading: Icon(this.icon),
          ),
        ),
        Divider()
      ],
    );
  }
}
