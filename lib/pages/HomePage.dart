import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vsing/pages/detail_table.dart';
import 'package:vsing/util/detailbook.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

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
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vsing Club",
                        style: TextStyle(fontSize: 28, color: Colors.black45),
                      ),
                      Text(
                        "Reservation",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // data
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: db.collection('user').get(),
                    builder: (context, snapshot) {
                      var data = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return detail_book(
                              name: data[index].data()['name'],
                              pax: data[index].data()['pax'],
                              date: data[index].data()['date'],
                              no: data[index].data()['table_no'],
                              floor: data[index].data()['floor']);
                        },
                      );
                    },
                  ))
            ],
          ),
        ));
  }
}
