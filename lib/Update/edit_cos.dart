import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vsing/Update/edit_table.dart';
import 'package:vsing/pages/spalsh.dart';
import 'package:vsing/style/color_constant.dart';
import 'package:intl/intl.dart';
import 'package:m_toast/m_toast.dart';

class Edit_Cos extends StatefulWidget {
  final name;
  final phone;
  final date;
  final floor;
  final no_table;
  final time;
  final pax;
  final remark;
  final attendance;
  final event;
  final bookdata;
  final paxdata;
  final id;

  const Edit_Cos({
    super.key,
    required this.name,
    required this.id,
    required this.remark,
    required this.phone,
    required this.date,
    required this.floor,
    required this.no_table,
    required this.time,
    required this.pax,
    required this.attendance,
    required this.event,
    required this.bookdata,
    required this.paxdata,
  });

  @override
  State<Edit_Cos> createState() => _Edit_CosState();
}

class _Edit_CosState extends State<Edit_Cos> {
  // input
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController remark = TextEditingController();

  int count = 0;
  String datetime = "";
  String time = "";
  var no = "";
  var attend = "";
  var colorbtn;
  var colortxt;

  // event
  var brtdy = "Brithday";
  var aniv = "Anniversary";
  var comp = "Company";
  var othr = "Bachelor Night";

  var onklik = '';
  //
  @override
  void initState() {
    super.initState();
    onklik = widget.event;
    var pax = int.parse(widget.pax);
    assert(pax is int);

    count = pax;
    name.text = widget.name;
    number.text = widget.phone;
    remark.text = widget.remark;
    attend = widget.attendance;
    time = widget.time;
    datetime = widget.date;

    // if (attend == 'Absent') {
    //   colorbtn = Color.fromARGB(255, 210, 209, 209);
    //   colortxt = Color.fromARGB(255, 73, 71, 83);
    // } else if (attend == 'Present') {
    //   colorbtn = Color.fromARGB(255, 73, 71, 83);
    //   colortxt = Color.fromARGB(255, 210, 209, 209);
    // }

    // no = widget.no_table.toString();
  }

  _updatetable() async {
    for (int x = 0; x <= widget.no_table.length - 1; ++x) {
      await FirebaseFirestore.instance
          .collection('table')
          .doc(widget.floor)
          .collection('lantai')
          .doc(widget.no_table[x].toString())
          .update({'status': 'Selected'});
    }
  }

  // log activity
  String Idmonth = '';
  String year = '';
  String month = '';
  String finalDate = '';

  //
  _addlog() async {
    setState(() {
      DateFormat bulan = DateFormat('MM');
      Idmonth = bulan.format(DateTime.now());

      DateFormat tahun = DateFormat('yyyy');
      year = tahun.format(DateTime.now());

      DateFormat bulanini = DateFormat('dd MMM yyyy');
      month = bulanini.format(DateTime.now());

      DateFormat bulanok = DateFormat('HH:mm');
      finalDate = bulanok.format(DateTime.now());
    });
    await FirebaseFirestore.instance
        .collection('History')
        .doc(year)
        .collection('month')
        .doc(Idmonth)
        .collection('bulan')
        .doc('report_${month + finalDate}')
        .set({
      "bulan": month,
      "time": finalDate.toString(),
      "Log_Msg": "update data ${widget.name} by Admin"
    });
  }

  // _updateattendance() async {
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(widget.name + widget.pax + widget.date)
  //       .update({
  //     'attendance': attend,
  //   });
  // }
  _searchByName() {
    var data = [];
    for (var i = 0; i < name.text.length; i++) {
      var potongan = name.text.substring(0, i + 1);
      data.add(potongan);
    }
    return data;
  }

  _searchByNumber() {
    var data = [];
    for (var i = 0; i < number.text.length; i++) {
      var potongan = number.text.substring(0, i + 1);
      data.add(potongan);
    }
    return data;
  }

  _searchByDate() {
    var data = [];
    for (var i = 0; i < datetime.length; i++) {
      var potongan = datetime.substring(0, i + 1);
      data.add(potongan);
    }
    return data;
  }

  _savebook() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.date)
        .collection('isi')
        .doc(name.text + count.toString() + datetime + number.text)
        .set({
      'name': name.text,
      'remark': remark.text,
      'pax': count.toString(),
      'date': datetime,
      'table_no': FieldValue.arrayUnion(widget.no_table),
      'event': onklik,
      "phone_number": number.text,
      'floor': widget.floor,
      "attendance": attend,
      'time': time,
      'search': FieldValue.arrayUnion(
          [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
    });
  }

  _delete() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.date)
        .collection('isi')
        .doc(widget.id)
        .delete();
  }

  // _updatebook() async {
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(widget.date)
  //       .collection('isi')
  //       .doc(widget.id)
  //       .update({
  //     "attendance": attend,
  //     // 'name': name.text,
  //     // 'remark': remark.text,
  //     // 'pax': count.toString(),
  //     // 'date': datetime,
  //     // 'table_no': FieldValue.arrayUnion(widget.no_table),
  //     // 'event': onklik,
  //     // "phone_number": number.text,
  //     // 'floor': widget.floor,
  //     // 'time': time,
  //     // 'search': FieldValue.arrayUnion(
  //     //     [..._searchByDate(), ..._searchByName(), ..._searchByNumber()]),
  //   });
  // }

  _bookpax() async {
    var book = int.parse(widget.bookdata) - 1;
    var pax = int.parse(widget.paxdata) - int.parse(widget.pax);
    await FirebaseFirestore.instance
        .collection('book&pax')
        .doc('book')
        .update({'book': book});
    await FirebaseFirestore.instance
        .collection('book&pax')
        .doc('pax')
        .update({'pax': pax});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text(
          'V Sing Ipoh Soho',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // input name
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Name",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: TextFormField(
                    controller: name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),

              // phone number input
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Phone Number",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: TextFormField(
                    controller: number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // const Padding(
              //   padding: EdgeInsets.only(bottom: 40),
              //   child: _userName(),
              // ),
              Text(
                "Pax",
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // minus btn
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (count > 0) {
                            count -= 1;
                          } else {
                            // do nothing
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 40,
                        color: Color(primaryColor),
                      )),
                  SizedBox(width: 20),
                  Text(
                    count.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(primaryColor),
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Plus btn
                  IconButton(
                      onPressed: () {
                        setState(() {
                          count += 1;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        size: 40,
                        color: Color(primaryColor),
                      )),
                ],
              ),
              SizedBox(height: 20),
              Text(
                datetime == "" ? "Choose Date & Time" : datetime + ' - ' + time,
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                // height: 100,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(primaryColor)),
                  ),
                  onPressed: () async {
                    var datetimeRet = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    var selectedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                      context: context,
                    );
                    String _addMissingZero(int minute) {
                      if (minute < 10) {
                        return '0$minute';
                      } else {
                        return minute.toString();
                      }
                    }

                    // Menggali dokumentasi ehe
                    initializeDateFormatting('id');
                    String formattedDate =
                        DateFormat.yMMMd('id').format(datetimeRet!);

                    setState(() {
                      datetime = formattedDate;
                      time =
                          '${selectedTime!.hour}:${_addMissingZero(selectedTime.minute)}';
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.date_range),
                      Text(
                        "Pick a date",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _updatetable();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Book(
                                  bookdata: widget.bookdata,
                                  paxdata: widget.paxdata,
                                  datebefore: widget.date,
                                  attendance: attend,
                                  remark: remark.text == ''
                                      ? widget.remark
                                      : remark.text,
                                  floor: widget.floor,
                                  no_table: widget.no_table,
                                  id: widget.name + widget.pax + widget.date,
                                  event: onklik,
                                  phone: number.text == ''
                                      ? widget.phone
                                      : number.text,
                                  name:
                                      name.text == '' ? widget.name : name.text,
                                  date: datetime == '' ? widget.date : datetime,
                                  time: time == '' ? widget.time : time,
                                  pax: count.toString(),
                                )));
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(primaryColor)),
                  ),
                  child: const Text(
                    "CHOOSE TABLE",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Book For",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // brtdy
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = brtdy;
                            print(onklik);
                          });
                        },
                        style: onklik == brtdy
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 129, 116, 211)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == brtdy
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.cakeCandles,
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.cakeCandles,
                                        color: Color(0xFF494753),
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      brtdy,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  // anniv
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = aniv;
                            print(onklik);
                          });
                        },
                        style: onklik == aniv
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 247, 156, 177)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == aniv
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Color(0xFF494753),
                                        size: 20,
                                      )),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      aniv,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // company
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = comp;
                            print(onklik);
                          });
                        },
                        style: onklik == comp
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 140, 155, 160)))
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == comp
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: Icon(Icons.business_center)),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      comp,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: Icon(Icons.business_center,
                                          color: Color(0xFF494753))),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      comp,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                  // bachelor
                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            onklik = othr;
                            print(onklik);
                          });
                        },
                        style: onklik == othr
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 86, 153, 109)),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 210, 209, 209)),
                              ),
                        child: onklik == othr
                            ? Row(
                                children: [
                                  SizedBox(width: 20, child: Icon(Icons.group)),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      othr,
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      width: 20,
                                      child: Icon(Icons.group,
                                          color: Color(0xFF494753))),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      othr,
                                      textAlign: TextAlign.center,
                                      // overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Color(0xFF494753)),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Remark",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: TextFormField(
                    controller: remark,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              // attendance
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Attendance",
                  style: TextStyle(
                    color: Color(primaryColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              attend == 'Absent'
                  ? Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // _updateattendance();

                          if (attend == 'Absent') {
                            setState(() {
                              attend = 'Present';
                            });
                          } else if (attend == 'Present') {
                            setState(() {
                              attend = 'Absent';
                            });
                          }
                          ShowMToast toast = ShowMToast();

                          toast.successToast(context,
                              message:
                                  "${widget.name} has arrived please go to next page for save",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.topCenter,
                              duration: 2100);
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 210, 209, 209)),
                        ),
                        child: const Text(
                          "Absent ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 73, 71, 83),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // _updateattendance();

                          if (attend == 'Absent') {
                            setState(() {
                              attend = 'Present';
                            });
                          } else if (attend == 'Present') {
                            setState(() {
                              attend = 'Absent';
                            });
                          }
                          ShowMToast toast = ShowMToast();

                          toast.errorToast(context,
                              message: "${widget.name} not arrived",
                              backgroundColor:
                                  Color.fromARGB(255, 239, 238, 238),
                              alignment: Alignment.topCenter,
                              duration: 1500);
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(primaryColor)),
                        ),
                        child: const Text(
                          "Present ",
                        ),
                      ),
                    ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _delete();
                      _addlog();
                      _savebook();

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return splash();
                      }), (r) {
                        return false;
                      });
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(primaryColor)),
                    ),
                    child: const Text(
                      "UPDATE",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
