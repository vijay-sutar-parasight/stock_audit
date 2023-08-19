import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import 'audit.dart';
import 'db_handler.dart';
import 'models/auditmodel.dart';

class AddAuditEntries extends StatefulWidget{
  @override
  State<AddAuditEntries> createState() => _AddAuditEntries();
}

class _AddAuditEntries extends State<AddAuditEntries>{
  var brand = TextEditingController();
  var format = TextEditingController();
  var variant = TextEditingController();
  var description = TextEditingController();
  var mfg_month = TextEditingController();
  var mfg_year = TextEditingController();
  var exp_month = TextEditingController();
  var exp_year = TextEditingController();
  var warehouse = TextEditingController();
  var weight = TextEditingController();
  var mrp = TextEditingController();
  var valuation_per_unit = TextEditingController();
  var system_unit = TextEditingController();
  var calculation = TextEditingController();
  var actual_units = TextEditingController();
  var total_valuation = TextEditingController();



  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  List statusDropdown = ['Active','Inactive'];
  String selectedItem = 'Active';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Audit Entries')
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: brand,
                decoration: InputDecoration(
                    hintText: 'Brand',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.deepOrange,
                            width: 2
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2
                        )
                    ),
                    prefixIcon: Icon(Icons.add_business, color: Colors.orange)
                ),
              ),
              Container(height: 11),
              TextField(
                  controller: format,
                  decoration: InputDecoration(
                      hintText: 'Format',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: variant,
                  decoration: InputDecoration(
                      hintText: 'Variant',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: description,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: mfg_month,
                  // decoration: InputDecoration(
                  //     hintText: 'MFG Month',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(11),
                  //         borderSide: BorderSide(
                  //           color: Colors.blue,
                  //         )
                  //     ),
                  //     prefixIcon: Icon(Icons.list_alt, color: Colors.orange)
                  //
                  // )

                  decoration: InputDecoration(
              icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Enter MFG Month" //label text of field
      ),
      readOnly: true,  //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
            context: context, initialDate: DateTime.now(),
            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101)
        );

        if(pickedDate != null ){
          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            dateinput.text = formattedDate; //set output date to TextField value.
          });
        }else{
          print("Date is not selected");
        }
      },

              ),
              Container(height: 11),
              TextField(
                  controller: mfg_year,
                  decoration: InputDecoration(
                      hintText: 'MFG Year',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: exp_month,
                  decoration: InputDecoration(
                      hintText: 'EXP Month',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: exp_year,
                  decoration: InputDecoration(
                      hintText: 'EXP Year',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: warehouse,
                  decoration: InputDecoration(
                      hintText: 'Warehouse',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: weight,
                  decoration: InputDecoration(
                      hintText: 'Weight',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: mrp,
                  decoration: InputDecoration(
                      hintText: 'MRP',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: valuation_per_unit,
                  decoration: InputDecoration(
                      hintText: 'Valuation Per Unit',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: system_unit,
                  decoration: InputDecoration(
                      hintText: 'System Unit',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: calculation,
                  decoration: InputDecoration(
                      hintText: 'Calculation',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: actual_units,
                  decoration: InputDecoration(
                      hintText: 'Actual Units',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                  controller: total_valuation,
                  decoration: InputDecoration(
                      hintText: 'Total Valuation',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              // Container(height: 20),
              // DropdownButton(
              //     value: selectedItem, items: statusDropdown.map((e) {
              //   return DropdownMenuItem(value: e,child: Text(e));
              // }).toList(), onChanged: (val){
              //   setState(() {
              //     selectedItem = val as String;
              //   });
              // }),
              Container(height: 20),
              ElevatedButton(onPressed: (){
                // String uCompany = company.text.toString();
                // String uDescription = shortDescription.text;
                // String uStatus = status.text;
                // dbHelper!.insert(
                //     AuditModel(
                //   title: uCompany,
                //   description: uDescription,
                //     )
                // ).then((value) {
                //   print('Data added Successfully');
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => Audit()));
                // }).onError((error, stackTrace) {
                //   print(error.toString());
                // });
                // print("Company: $uCompany, Description: $uDescription, Status: $uStatus");
              }, child: Text(
                  'Save'
              ))
            ],
          )
      ),
    );
  }
}