import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vsing/pages/Update/edit_cos.dart';

class detail_book extends StatelessWidget {
  final name;
  final phone;
  final pax;
  final date;
  final time;
  final no;

  final floor;
  final event;
  const detail_book({
    super.key,
    required this.name,
    required this.phone,
    required this.pax,
    required this.date,
    required this.time,
    required this.no,
    required this.event,
    required this.floor,
  });

  @override
  Widget build(BuildContext context) {
    // function delete data
    Future deleteData(String id) async {
      try {
        await FirebaseFirestore.instance.collection("user").doc(id).delete();
        // await FirebaseFirestore.instance
        //     .collection("table")
        //     .doc(lantai)
        //     .collection('lantai')
        //     .doc(no)
        //     .update({
        //   'status': 'Avail',
        // });
        for (int x = 0; x <= no.length - 1; ++x) {
          await FirebaseFirestore.instance
              .collection('table')
              .doc(floor)
              .collection('lantai')
              .doc(no[x].toString())
              .update({'status': 'Avail'});
        }
      } catch (e) {
        return false;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$name",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    phone,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Pax : $pax - $event",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Table : ${no.join(",")} $floor",
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )),
              Container(
                width: 3,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                width: 100,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Date & Time",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "$date",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$time",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: 3,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                width: 50,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      child: IconButton(
                          onPressed: () {
                            deleteData(name + pax + date);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                          )),
                    ),

                    // Text(_counter.toString()),
                    Positioned(
                        top: 1,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Edit_Cos(
                                        event: event,
                                        name: name,
                                        phone: phone,
                                        date: date,
                                        floor: floor,
                                        no_table: no,
                                        time: time,
                                        pax: pax),
                                  ));
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 20,
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
