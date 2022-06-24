import 'package:flutter/material.dart';
import '../Utils/Global.dart';

class DetailUserPage extends StatelessWidget {
  const DetailUserPage({Key? key}) : super(key: key);

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
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Spacer(),
            Text(
              "Paco Salazar",
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
                    height: 120.0)),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "ps@gmail.com",
                style: TextStyle(
                    height: 1, fontSize: 17, color: Global.colorBase3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "User Type: Admin",
                style:
                    TextStyle(height: 1, fontSize: 17, color: Global.colorBase),
              ),
            ),
            Spacer(flex: 3),
          ]),
        ));
  }
}
