import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interview/data/user.dart';
import 'package:interview/data/mock_data.dart';
import 'package:interview/widgets/avatar/avatar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();
  List<User> myUsers = [];
  List<User> filteredList = [];
  @override
  void initState() {
    super.initState();
    searchController.addListener((() => _filterList()));
    _getUsers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  _getUsers() async {
    myUsers = User.fromJsonToList(json);
    log(myUsers.length.toString());
    return filteredList = myUsers;
  }

  _addUser(User newUser) {
    setState(() {
      myUsers.insert(0, newUser);
    });
  }

  _filterList() {
    filteredList = myUsers
        .where(
          (element) =>
              element.firstName.toLowerCase().isNotEmpty &&
              element.firstName.toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ),
        )
        .toList();
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                controller: searchController,
                onFieldSubmitted: (value) {
                  setState(() {
                    searchController.clear();
                  });
                },
                onChanged: (value) {
                  searchController.addListener(_filterList);
                  setState(() {
                    _filterList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Avatar(user: filteredList[index]),
                  title: Text(
                      "${filteredList[index].firstName} ${filteredList[index].lastName}"),
                  subtitle: Text(
                    filteredList[index].role,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newUser = User(
            id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d",
            avatar: null,
            firstName: "James",
            lastName: "May",
            email: "ssaull1c@tripod.com",
            role: "Developer",
          );
          setState(() {
            _addUser(newUser);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${newUser.firstName} was added Successfully!"),
            ),
          );
          addUsers(myUsers);
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}
