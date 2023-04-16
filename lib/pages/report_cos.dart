import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vsing/pages/report_cos_detail.dart';

class report_view extends StatefulWidget {
  report_view({super.key});

  @override
  State<report_view> createState() => _report_viewState();
}

class _report_viewState extends State<report_view> {
  bool load = true, keyword = false;
  List namas = [], results = [];
  var number, nama;
  List<String> dataList = [];
  var search = '';
  String searchValue = '';

  TextEditingController searchValues = TextEditingController();

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      getAndFilter();
      setState(() {
        keyword = false;
        print(keyword);
      });
    } else if (enteredKeyword.isNotEmpty) {
      List exp = namas
          .where((namas) =>
              namas.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      results = exp.toList();
      print(results);
    }
    setState(() {
      keyword = true;
      print(keyword);
    });
  }

  getAndFilter() async {
    // Menghapus data duplikat pada list
    final data = await FirebaseFirestore.instance
        .collection('Vsing-rsv')
        .doc('reservation')
        .collection('user-list')
        .get();
    var unfiltered = [
      for (final d in data.docs)
        '${d.data()['name']}' + ',' '${d.data()['phone_number']}'
    ];

    List namaFilter = unfiltered.toSet().toList();
    namas = namaFilter;
    print("Data setelah dihapus duplikat: $namas");
  }

  @override
  void initState() {
    super.initState();
    getAndFilter();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (load == false)
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Report Customers',
                style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color.fromARGB(232, 232, 231, 231),
            ),
            backgroundColor: Color.fromARGB(232, 250, 250, 250),
            body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 40.h,
                      child: TextFormField(
                        onChanged: (value) => _runFilter(value),
                        controller: searchValues,
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Color.fromARGB(255, 85, 71, 117),
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            size: 30.w,
                            color: Color.fromARGB(255, 85, 71, 117),
                          ),
                          hintText: 'Search by name or phone number',
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: Color.fromARGB(255, 85, 71, 117),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15.r)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    results.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: results.length,
                                itemBuilder: (context, index) {
                                  print(searchValues.text);
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Cos_detail(
                                              name:
                                                  results[index].split(",")[0],
                                              phone:
                                                  results[index].split(",")[1],
                                            ),
                                          ));
                                    },
                                    child: Card_history(
                                        name: results[index].split(",")[0],
                                        phone: results[index].split(",")[1]),
                                  );
                                }))
                        : searchValues.text == ''
                            ? Expanded(
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: namas.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Cos_detail(
                                                  name: namas[index]
                                                      .split(",")[0],
                                                  phone: namas[index]
                                                      .split(",")[1],
                                                ),
                                              ));
                                        },
                                        child: Card_history(
                                            name: namas[index].split(",")[0],
                                            phone: namas[index].split(",")[1]),
                                      );
                                    }))
                            : Expanded(
                                child: Center(
                                child: Text('kosong'),
                              ))
                  ],
                )))
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 56, 43, 83),
              ),
            ),
          );
  }
}

class Card_history extends StatelessWidget {
  final name;
  final phone;
  const Card_history({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    _saveContact() async {
      Contact contact = Contact();
      contact.familyName = name;
      contact.phones = [Item(label: "mobile", value: phone)];

      if (await Permission.contacts.request().isGranted) {
        await ContactsService.addContact(contact);
        print("Contact added successfully");
        print(name);
        print(phone);
        return contact;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 85, 71, 117)),
                  ),
                  Text(
                    phone,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 85, 71, 117)),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    // _saveContactme();

                    // _makePhoneCall('tel:0597924917');
                    NAlertDialog(
                      dialogStyle: DialogStyle(titleDivider: true),
                      title: Text(
                        "Save Contact",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      content: Text("Save This Costumer To Your Contact?...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      actions: <Widget>[
                        TextButton(
                            child: Text("Okay",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Color.fromARGB(255, 192, 34, 23))),
                            onPressed: () {
                              _saveContact();
                              Navigator.pop(context);
                            }),
                        TextButton(
                            child: Text("Cancel",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color.fromARGB(255, 54, 51, 140),
                                )),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ).show(context);
                    // UrlLauncher.launch('tel:${phone.toString()}');
                  },
                  icon: Icon(
                    Icons.save,
                    color: Color.fromARGB(255, 85, 71, 117),
                    size: 40.w,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
