import 'package:flutter/material.dart';

class detail_book extends StatelessWidget {
  final name;
  final pax;
  final date;
  final no;
  final floor;
  const detail_book({
    super.key,
    required this.name,
    required this.pax,
    required this.date,
    required this.no,
    required this.floor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Pax",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        pax,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 25),
                Container(
                  width: 3,
                  height: 50,
                  color: Colors.black,
                ),
                SizedBox(width: 25),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Table",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '  $no     $floor',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Date & Time',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            Text(
              date,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
