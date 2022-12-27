import 'dart:convert';

import 'package:flutter/material.dart';

class detail_book extends StatelessWidget {
  final name;
  final phone;
  final pax;
  final date;
  final time;
  final no;
  final floor;
  const detail_book({
    super.key,
    required this.name,
    required this.phone,
    required this.pax,
    required this.date,
    required this.time,
    required this.no,
    required this.floor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    phone,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Pax : $pax",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Floor : $no $floor",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
              Container(
                width: 4,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                width: 150,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Date & Time",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "$date",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$time",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
