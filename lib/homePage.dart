import 'package:flutter/material.dart';
import 'package:whatsapp/login/Login.dart';
import 'package:whatsapp/pages/calls.dart';
import 'package:whatsapp/pages/camera.dart';
import 'package:whatsapp/pages/chats.dart';
import 'package:whatsapp/pages/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: listView(),
      ),
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          cameraScreen(),
          chatScreen(),
          statusScreen(),
          callScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {
            print("FAB clicked");
          }),
    );
  }

  Widget listView() {
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Yash Johri"),
          accountEmail: Text("yashjohri1200@gmail.com"),
        ),
        ListTile(
          title: Text("Sign Out"),
          leading: Icon(
            Icons.transit_enterexit,
            color: Colors.black,
          ),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context){
                  return Login();
            }));
          },
        ),
        ListTile(
          title: Text("Exit"),
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.black,
          ),
          onTap: () {
            exit(0);
          },
        )
      ],
    );
  }
}
