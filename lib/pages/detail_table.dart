import 'package:flutter/material.dart';
import 'package:vsing/pages/TableBook.dart';
import 'package:vsing/style/color_constant.dart';

class TableDetails extends StatefulWidget {
  const TableDetails({super.key});

  @override
  State<TableDetails> createState() => _TableDetailsState();
}

class _TableDetailsState extends State<TableDetails> {
  // input
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove appbar shadow / elevated effects
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Center(child: _VsingClubLogo()),
              const Text(
                "Vsing Club",
                style: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
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
              Container(
                width: 200,
                height: 40,
                child: TextFormField(
                  controller: name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'data kosong';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // const Padding(
              //   padding: EdgeInsets.only(bottom: 40),
              //   child: _userName(),
              // ),
              const _pax(),
              // const Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: _table(),
              // ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: _pickDate(),
              ),
              Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(primaryColor)),
                  ),
                  child: const Text(
                    "CONFIRM",
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _VsingClubLogo extends StatelessWidget {
  const _VsingClubLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: const BoxDecoration(
        // [TODO] Add image Vsing image here
        // image: DecorationImage(image: ),
        color: Color(primaryColor),
        shape: BoxShape.circle,
      ),
      // [INFO] For now placeholder user image
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 100,
      ),
    );
  }
}

class _userName extends StatelessWidget {
  const _userName({
    super.key,
    this.username = "Agung",
  });
  final String username;
  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: const TextStyle(
        color: Color(primaryColor),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _pax extends StatefulWidget {
  const _pax({super.key});

  @override
  State<_pax> createState() => _paxState();
}

class _paxState extends State<_pax> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Pax",
          style: TextStyle(
            color: Color(primaryColor),
            fontSize: 20,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: const TextStyle(
                color: Color(primaryColor),
                fontSize: 20,
              ),
            ),
            Container(
              height: 80,
              child: Stack(
                children: [
                  // minus
                  Positioned(
                    top: 30,
                    child: IconButton(
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
                          size: 30,
                          color: Color(primaryColor),
                        )),
                  ),

                  // pluss
                  Positioned(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              count += 1;
                            });
                          },
                          icon: Icon(
                            Icons.add_circle,
                            size: 30,
                            color: Color(primaryColor),
                          ))),
                ],
              ),
            ),
            // Column(
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         setState(() {
            //           count += 1;
            //         });
            //       },
            //       child: const Text(
            //         "+",
            //         style: TextStyle(
            //           color: Color(primaryColor),
            //           fontSize: 20,
            //         ),
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         setState(() {
            //           if (count > 0) {
            //             count -= 1;
            //           } else {
            //             // do nothing
            //           }
            //         });
            //       },
            //       child: const Text(
            //         "-",
            //         style: TextStyle(
            //           color: Color(primaryColor),
            //           fontSize: 20,
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        )
      ],
    );
  }
}

class _table extends StatefulWidget {
  const _table({super.key});

  @override
  State<_table> createState() => __tableState();
}

class __tableState extends State<_table> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Table",
          style: TextStyle(
            color: Color(primaryColor),
            fontSize: 20,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Table_Book(),
                ));
          },
          style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(Color(primaryColor)),
          ),
          child: const Text(
            "CHOOSE TABLE",
          ),
        ),
      ],
    );
  }
}

class _pickDate extends StatefulWidget {
  const _pickDate({super.key});

  @override
  State<_pickDate> createState() => __pickDateState();
}

class __pickDateState extends State<_pickDate> {
  String datetime = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Choose Date & Time",
          style: TextStyle(
            color: Color(primaryColor),
            fontSize: 20,
          ),
        ),
        Text(
          datetime,
          style: TextStyle(
            color: Color(primaryColor),
            fontSize: 20,
          ),
        ),
        Container(
          width: 150,
          // height: 100,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                datetime = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100))
                    .toString();
              });
            },
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(primaryColor)),
            ),
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
      ],
    );
  }
}