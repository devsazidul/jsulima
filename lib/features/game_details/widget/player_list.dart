import 'package:flutter/material.dart';

class PlayerList extends StatelessWidget {
  const PlayerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[800],
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child:
                  index < 2
                      ? Image.asset('assets/icons/userprofile.png')
                      : null,
            ),
            title: Text(
              'Item \$index',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Subtitle \$index',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '#$index',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 19,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
