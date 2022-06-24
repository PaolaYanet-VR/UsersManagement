import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_management_flutter_app/Models/UserModel.dart';
import 'package:users_management_flutter_app/Pages/SignUpPage.dart';
import 'package:users_management_flutter_app/Pages/UsersPage.dart';
import 'package:users_management_flutter_app/Widgets/button_widget.dart';
import 'package:users_management_flutter_app/Widgets/textfield_widget.dart';
import '../Utils/Global.dart';

var userAdmin = false;

class LogInPage extends StatelessWidget {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Global.colorBack,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: ListView(children: [
            Container(
                child: StreamBuilder<QuerySnapshot>(
              stream: users,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                final data = snapshot.requireData;

                data.docs.forEach((u) {
                  UserModel auxUser = UserModel();
                  auxUser.id = u['id'];
                  auxUser.name = u['name'];
                  auxUser.lastname = u['lastname'];
                  auxUser.email = u['email'];
                  auxUser.password = u['password'];
                  usersList.add(UserModel());
                });

                return Spacer();
              },
            )),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Log In",
                style: TextStyle(
                    height: 1,
                    fontSize: 23,
                    color: Global.colorBase,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Global.colorBack,
                  backgroundImage: NetworkImage(
                      'https://cdn.discordapp.com/attachments/956669281813299230/989664044816429066/account.png'),
                ),
              ),
              const TextFieldWidget(
                  isPrefixIcon: false,
                  isSuffixIcon: false,
                  isMyControllerActivated: true,
                  hintText: "E-mail"),
              const TextFieldWidget(
                  isPrefixIcon: false,
                  isSuffixIcon: false,
                  isMyControllerActivated: true,
                  hintText: "Password"),
              ButtonWidget(
                  colorButton: Global.colorBase,
                  color: Global.colorBack,
                  title: "Log In",
                  hasColor: false,
                  onPressed: () {
                    // Do Log in

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => UsersPage()));
                  }),
              ButtonWidget(
                  colorButton: Global.colorBack,
                  color: Global.colorBase,
                  title: "Or Sign Up",
                  hasColor: false,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage()));
                  })
            ]),
          ]),
        ));
  }
}
