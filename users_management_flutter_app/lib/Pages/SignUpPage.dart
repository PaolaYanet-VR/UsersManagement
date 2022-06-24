import 'package:flutter/material.dart';
import 'package:users_management_flutter_app/Pages/LogInPage.dart';
import '../Utils/Global.dart';
import '../Widgets/button_widget.dart';
import '../Widgets/textfield_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 40.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Image.network(
                      'https://cdn.discordapp.com/attachments/956669281813299230/989678001845334087/unknown.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            },
          ),
          backgroundColor: Global.colorBack,
          foregroundColor: Global.colorBase,
        ),
        backgroundColor: Global.colorBack,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Sign Up",
            style: TextStyle(
                height: 1,
                fontSize: 23,
                color: Global.colorBase,
                fontWeight: FontWeight.bold),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: Image(
                image: NetworkImage(
                    'https://cdn.discordapp.com/attachments/956669281813299230/989685249262907403/add-contact.png'),
                height: 120.0,
              )),
          TextFieldWidget(
              isPrefixIcon: false,
              isSuffixIcon: false,
              isMyControllerActivated: true,
              hintText: "Firstname"),
          TextFieldWidget(
              isPrefixIcon: false,
              isSuffixIcon: false,
              isMyControllerActivated: true,
              hintText: "Lastname"),
          TextFieldWidget(
              isPrefixIcon: false,
              isSuffixIcon: false,
              isMyControllerActivated: true,
              hintText: "E-mail"),
          TextFieldWidget(
              isPrefixIcon: false,
              isSuffixIcon: false,
              isMyControllerActivated: true,
              hintText: "Password"),
          ButtonWidget(
              colorButton: Global.colorBase,
              color: Global.colorBack,
              title: "Sign Up",
              hasColor: false,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const LogInPage()));
              })
        ]));
  }
}
