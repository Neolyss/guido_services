import 'package:admin/models/generique.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../models/RecentFile.dart';

class CommandsView extends StatefulWidget {
  const CommandsView({Key? key}) : super(key: key);

  @override
  _CommandsViewState createState() => _CommandsViewState();
}

class _CommandsViewState extends State<CommandsView> {

  Future<Map<String, dynamic>> getCommands(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return G.commandeInfoAllResponsable(prefs.getString("login"));
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Commands",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton.icon(
                  onPressed: () => { Navigator.pushNamed(context, "/newCommand"), },
                  icon: Icon(Icons.add),
                  label: Text("New Command"),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(defaultPadding)),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<Map<String, dynamic>>(
              //future: getCommands(context),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    runSpacing: 10,
                    children: [
                      CommandView(),
                    ],
                  );
                } else if(snapshot.hasError) 
                  return Container();
                else {
                  return Container();
                }
              },
            )
          ),
        ],
      ),
    );
  }
}

class CommandView extends StatefulWidget {
  const CommandView({Key? key}) : super(key: key);

  @override
  _CommandViewState createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Command mes couilles"),
          IconButton(
              onPressed: () => { Navigator.pushNamed(context, "/command"), },
              icon: Icon(Icons.edit),
          ),
        ],
      ),
      //subtitle: Text('Trailing expansion arrow icon'),
      children: <Widget>[
        ListTile(title: Text('This is tile number 1')),
      ],
    );
  }
}

