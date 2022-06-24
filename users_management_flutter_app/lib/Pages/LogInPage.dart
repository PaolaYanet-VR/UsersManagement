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

  final TextEditingController _controllerTxtEmail = TextEditingController();
  final TextEditingController _controllerTxtPassword = TextEditingController();

  var email = '';
  var password = '';
  var admin = false;
  var data;

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
                if (snapshot.hasError) {
                  return Text('Something went wrong :(');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                data = snapshot.requireData;
                
                data.docs.forEach((doc) {
                  UserModel auxUser = UserModel();
                  auxUser.id = doc.id;
                  auxUser.name = doc['name'];
                  auxUser.lastname = doc['lastname'];
                  auxUser.admin = doc['admin'] as bool;
                  auxUser.email = doc['email'];
                  auxUser.password = doc['password'];
                  usersList.add(auxUser);
                  //print(doc['email']);
                });

                return Text("");
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
              TextFieldWidget(
                  isPrefixIcon: false,
                  isSuffixIcon: false,
                  isMyControllerActivated: true,
                  controller: _controllerTxtEmail,
                  onChanged: (value) {
                    email = value;
                  },
                  hintText: "E-mail"),
              TextFieldWidget(
                  isPrefixIcon: false,
                  isSuffixIcon: false,
                  isMyControllerActivated: true,
                  controller: _controllerTxtPassword,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  hintText: "Password"),
              ButtonWidget(
                  colorButton: Global.colorBase,
                  color: Global.colorBack,
                  title: "Log In",
                  hasColor: false,
                  onPressed: () {
                    // Do Log in

                    var logIn = false;

                    usersList.forEach((u) {
                      if (u.email == email && u.password == password) {
                        actualUser = u;
                        logIn = true;
                        if (u.admin == true) {
                          userAdmin = true;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => UsersPage()));
                        } else {
                          // Is not admin
                          print("no es admin");
                        }
                      }
                    });
                  }),
              ButtonWidget(
                  colorButton: Global.colorBack,
                  color: Global.colorBase,
                  title: "Or Sign Up",
                  hasColor: false,
                  onPressed: () {
                    userAdmin = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage()));
                  })
            ]),
          ]),
        ));
  }
}
