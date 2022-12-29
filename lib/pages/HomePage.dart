import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vsing/pages/Input/input_cos.dart';
import 'package:vsing/util/detailbook.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // database
  final db = FirebaseFirestore.instance;

// Search func
  List searchResult = [];

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('user')
        .where('search', arrayContains: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableDetails(),
                ));
          },
          child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Icon(
                Icons.add_circle,
                size: 50,
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(232, 255, 253, 253),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // title
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "V Sing Ipoh Soho",
                        style: TextStyle(fontSize: 23, color: Colors.black45),
                      ),
                      Text(
                        "Reservation",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          onChanged: (query) {
                            searchFromFirebase(query);
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintText: 'Search by name, date or phone number',
                            hintStyle: TextStyle(fontSize: 15),
                            filled: true,
                            fillColor: Color.fromARGB(255, 238, 238, 238),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              searchResult.isEmpty
                  // if no search
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 530,
                      child: StreamBuilder(
                        stream: db.collection('user').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("eror"),
                            );
                          }
                          var data = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return detail_book(
                                  event: data[index].data()['event'],
                                  name: data[index].data()['name'],
                                  phone: data[index].data()['phone_number'],
                                  pax: data[index].data()['pax'],
                                  date: data[index].data()['date'],
                                  time: data[index].data()['time'],
                                  no: data[index].data()['table_no'],
                                  floor: data[index].data()['floor']);
                            },
                          );
                        },
                      ))

                  // if search
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 530,
                      child: ListView.builder(
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          return detail_book(
                              event: searchResult[index]['event'],
                              name: searchResult[index]['name'],
                              phone: searchResult[index]['phone_number'],
                              pax: searchResult[index]['pax'],
                              date: searchResult[index]['date'],
                              time: searchResult[index]['time'],
                              no: searchResult[index]['table_no'],
                              floor: searchResult[index]['floor']);
                        },
                      ),
                    )
            ],
          ),
        ));
  }
}
