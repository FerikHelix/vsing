import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cos_detail extends StatefulWidget {
  final name;
  final phone;
  const Cos_detail({super.key, required this.name, required this.phone});

  @override
  State<Cos_detail> createState() => _Cos_detailState();
}

class _Cos_detailState extends State<Cos_detail> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              widget.phone,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(232, 232, 231, 231),
      ),
      backgroundColor: Color.fromARGB(232, 250, 250, 250),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            // width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collectionGroup('user-list')
                    .where('name', isEqualTo: widget.name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 85, 71, 117),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("eror"),
                    );
                  }
                  var data = snapshot.data!.docs;

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card_history(
                          date: data[index].data()['date'],
                          pax: data[index].data()['pax']);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class Card_history extends StatelessWidget {
  final date;
  final pax;
  const Card_history({super.key, required this.date, required this.pax});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 30),
          child: Row(
            children: [
              Text(
                date,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 85, 71, 117),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Pax',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromARGB(255, 85, 71, 117),
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    pax,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromARGB(255, 85, 71, 117),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
