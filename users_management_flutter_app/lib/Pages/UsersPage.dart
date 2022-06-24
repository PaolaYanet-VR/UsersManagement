import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_management_flutter_app/Pages/LogInPage.dart';
import 'package:users_management_flutter_app/Pages/SignUpPage.dart';
import 'package:users_management_flutter_app/Widgets/row_widget.dart';
import '../Utils/Global.dart';

class UsersPage extends StatelessWidget {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leadingWidth: 40.0,
        title: Text('Welcome User!'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Image.network(
                    'https://cdn.discordapp.com/attachments/956669281813299230/989698368009805896/log-out.png'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LogInPage()));
                });
          },
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: IconButton(
                    icon: Image.network(
                        'https://cdn.discordapp.com/attachments/956669281813299230/989698814631882812/plus.png'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignUpPage()));
                    }),
              );
            },
          )
        ],
        backgroundColor: Global.colorBack,
        foregroundColor: Global.colorBase,
      ),
      backgroundColor: Global.colorBack,
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong :(');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          final data = snapshot.requireData;

          return ListView.separated(
              itemCount: data.size,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      RowWidget(
                        title: '${data.docs[index]['name']} ${data.docs[index]['lastname']}',
                        hasColor: false,
                      )
                    ],
                  ),
                );
              });
        },
      )),
    );
  }
}
