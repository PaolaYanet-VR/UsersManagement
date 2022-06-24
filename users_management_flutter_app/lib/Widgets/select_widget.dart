import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:users_management_flutter_app/Pages/SignUpPage.dart';

class SelectWidget extends StatefulWidget {
  SelectWidget({Key? key}) : super(key: key);

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  final elements1 = [
    "Admin",
    "Normal",
    
  ];

  int selectedIndex1 = 0,
      selectedIndex2 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 50.0, left: 50.0),
      child: DirectSelect(
          itemExtent: 38.0,
          selectedIndex: selectedIndex1,
          child: MySelectionItem(
            isForList: false,
            title: elements1[selectedIndex1],
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              if(index == 0){
                admin = true;
              }else{
                admin = false;
              }
              print(admin);
              selectedIndex1 = index;
            });
          },
          mode: DirectSelectMode.tap,
          items: _buildItems1()),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key? key, required this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: FittedBox(
          child: Text(
        title, style: TextStyle(fontSize: 18),
      )),
    );
  }
}
