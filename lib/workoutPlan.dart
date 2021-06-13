import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_select/smart_select.dart';
import 'package:sumoapp/databaseHelper.dart';
import 'login.dart';

class workoutPlan extends StatefulWidget {
  final int userID;
  final String haha;

  const workoutPlan(this.userID, this.haha);
  @override
  _workoutPlan createState() => _workoutPlan();
}

class _workoutPlan extends State<workoutPlan> {
  DatabaseHelper db = DatabaseHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late List<Map<dynamic, dynamic>> list;
  @override
  void initState() {
    super.initState();
  }

  String value = 'flutter';
  int id = id_variable.user_Id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: SizedBox(
            height: 80,
            width: 80,
            child: Image.asset("asset/DynaBeatLogo.png"),
          ),
          backgroundColor: Color(0xFF580400),
          centerTitle: true,
          title: Text(
            'Your Workout Plan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder<List>(
          future: db.getWorkoutDetails(widget.userID),
          initialData: [],
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: (snapshot.data!.length),
                    itemBuilder: (_, int position) {
                      return Dismissible(
                        key: ValueKey(position),
                        child: ListTile(
                          title: Text(snapshot.data![(position)].row[0]),
                          subtitle: Text(""),
                        ),
                        onDismissed: (direction) {
                          setState(() async {
                            await db.DeleteItem(
                                snapshot.data![(position)].row[1]);
                            snapshot.data!.removeAt(position);
                          });
                        },
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        endDrawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(
                0xFF402929), //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(
            elevation: 10.0,
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF4B0F0F)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'data:image/jpeg;base64,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'),
                        radius: 40.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.haha,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25.0),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      )
                    ],
                  ),
                ),

                //Here you place your menu items
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home Page', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    // Here you can give your route to navigate
                  },
                ),
                Divider(height: 3.0),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    // Here you can give your route to navigate
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    // Here you can give your route to navigate
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text('Delete Account', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    _scaffoldKey.currentState!.showSnackBar(SnackBar(
                      content: Text('Are you sure to delete account?'),
                      duration: Duration(seconds: 10),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'Yes',
                        onPressed: () {
                          print(widget.userID);
                          db.DeleteAccount(widget.userID);
                          Navigator.pop(context);
                        },
                      ),
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
