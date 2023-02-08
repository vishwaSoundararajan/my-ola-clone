import 'package:flutter/material.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:myolaapp/scrollscreen.dart';

class Display extends StatelessWidget {
  const Display({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchHome(),
    );
  }
}

class SearchHome extends StatefulWidget {

  const SearchHome({Key? key}) : super(key: key);

  @override
  _SearchHome createState() => _SearchHome();
}

class _SearchHome extends State<SearchHome> {

  final _olasdkPlugin=Fluttersdkplugin();
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "place": "Egmore", "address": "Gandhi Irwin Rd,Egmore,Chennai"},
    {"id": 2, "place": "Marina Beach", "address": "Marina Beach, Tamil Nadu"},
    {"id": 3, "place": "Phoenix", "address": "Phoenix Market City, 142,Velachery Main Rd,Chennai"},
    {"id": 4, "place": "Cmbt", "address": "CMBT Passanger Way, Koyambedu,Chennai"},
    {"id": 5, "place": "Thiruvanmiyur", "address": "Thiruanmiyur,Chennai"},
    {"id": 6, "place": "Guindy", "address": "Guindy,Chennai"},
    {"id": 7, "place": "Porur", "address": "Porur,Chennai"},
    {"id": 8, "place": "Thiruvannamalai", "address": "Tamil Nadu, India"},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {


    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["place"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: Colors.white,shadowColor: Colors.white,
        title: const Text('Destination',style:TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            //new added
            Container(
              margin: EdgeInsets.fromLTRB(0,0,0,0),
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              height:100 ,
              width:double.infinity,

              decoration: const BoxDecoration(

                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.10,
                    spreadRadius: 1.0,
                    offset: Offset(0.0,0.0), // shadow direction: bottom right
                  )
                ],
              ),

              child:Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0,20,0,0),
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),

                      Container(
                          margin: const EdgeInsets.fromLTRB(0,8,0,6),
                          color: Colors.black26,
                          child:const SizedBox(
                            height:30 ,
                            width: 2,
                          )
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        margin: EdgeInsets.fromLTRB(0,0,0,0),
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 280,
                        height: 40,
                        margin:  EdgeInsets.fromLTRB(14,4,0,0),
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          onTap:() => {
                          _olasdkPlugin.pushLocation(13.0827,80.2707),
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>  const Destination())

                            ),

                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search for an address or landmark",suffixStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.fromLTRB(28,7,0,0),
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        color: Colors.black12,
                        child: const SizedBox(
                          width:280,
                          height:0.50,
                        ),
                      ),
                      Container(
                        width: 280,
                        height: 40,
                        margin:  EdgeInsets.fromLTRB(14,4,0,0),
                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          onTap:() => {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>  const Destination())
                            ),

                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Enter Destination",suffixStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            //New added


            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.location_on_rounded,
                        color: Colors.grey[500],
                      ),
                    ),
                    title: Text(_foundUsers[index]['place'], style:TextStyle(
                        color:Colors.black
                    )),
                    subtitle: Text(
                        '${_foundUsers[index]["address"]}',style:TextStyle(
                        color:Colors.black
                    )),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}