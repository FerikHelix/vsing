import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vsing/pages/HomePage.dart';
import 'package:vsing/pages/detail_table.dart';
import 'package:vsing/util/table.dart';
import '../style/color_constant.dart';

class Table_Book extends StatefulWidget {
  final name;
  final pax;
  final date;
  const Table_Book(
      {super.key, required this.name, required this.date, required this.pax});

  @override
  State<Table_Book> createState() => _Table_BookState();
}

class _Table_BookState extends State<Table_Book> {
  bool select = false;
  var status = '';
  var no = '';
  var lantai = 'Pilih Lantai';

  List selectedTable = [];
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    _update() async {
      await db
          .collection('table')
          .doc(lantai)
          .collection('lantai')
          .doc(no)
          .update({'status': 'Selected'});
    }

    _updateselected() async {
      await db
          .collection('table')
          .doc(lantai)
          .collection('lantai')
          .doc(no)
          .update({'status': 'Avail'});
    }

    _savebook() async {
      await db
          .collection('user')
          .doc(widget.name + widget.pax + widget.date)
          .set({
        'name': widget.name,
        'pax': widget.pax,
        'date': widget.date,
        'table_no': no,
        'floor': lantai,
      });
      await db
          .collection('table')
          .doc(lantai)
          .collection('lantai')
          .doc(no)
          .update({'status': 'Book'});
    }

    return Scaffold(
      // button
      bottomNavigationBar: InkWell(
        onTap: () {
          _savebook();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return HomePage();
          }), (r) {
            return false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: Color(primaryColor),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text('Book'),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Select Table',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text(widget.name + ',' + widget.date + ',' + widget.pax),
            // lantai
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lantai,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              child: FutureBuilder(
                                future: db.collection('table').get(),
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
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            lantai =
                                                data[index].data()['lantai'];
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                data[index].data()['lantai'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 30,
                      ))
                ],
              ),
            ),

            // stage
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Center(
                child: Text(
                  'STAGE',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),

            // tablet
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: FutureBuilder(
                  future: db
                      .collection('table')
                      .doc(lantai)
                      .collection('lantai')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 50,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6),
                        itemCount: data.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                no = data[index].data()['no'];
                                status = data[index].data()['status'];
                              });

                              if (status == 'Avail') {
                                _update();
                              } else if (status == 'Selected') {
                                _updateselected();
                              } else if (status == 'Book') {}
                            },
                            child: tableui(
                              cekno: no,
                              no: data[index].data()['no'],
                              status: status,
                              cekstatus: data[index].data()['status'],
                            ),
                          );
                        });
                  }),
            ),

            // info

            // available
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Available',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // selected
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 221, 20, 124)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Selected',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // reserved
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 2, 161, 234)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Reserved',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // status != 'Selected' ? Text('Book no : $no') : SizedBox()
          ],
        ),
      ),
    );
  }
}
