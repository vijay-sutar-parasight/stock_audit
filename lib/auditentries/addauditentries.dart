import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../models/auditentriesmodel.dart';
import 'auditentries.dart';
import 'auditentries_handler.dart';

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



  AuditentriesDBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = AuditentriesDBHelper();
  }

  List statusDropdown = ['Active','Inactive'];
  String selectedItem = 'Active';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Audit Entries')
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextField(
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
                            prefixIcon: Icon(Icons.add_business, color: Colors.orange),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: format,
                          decoration: InputDecoration(
                              hintText: 'Format',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),

                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: variant,
                          decoration: InputDecoration(
                              hintText: 'Variant',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: description,
                          decoration: InputDecoration(
                              hintText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),
                Container(height: 11),
                
                Container(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: TextField(
                          controller: mfg_month,
                          decoration: InputDecoration(

                              hintText: 'MFG Month',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          ),
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: mfg_year,
                          decoration: InputDecoration(
                              hintText: 'MFG Year',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),

                  ],
                ),


                Container(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: TextField(
                          controller: exp_month,
                          decoration: InputDecoration(
                              hintText: 'EXP Month',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: exp_year,
                          decoration: InputDecoration(
                              hintText: 'EXP Year',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),
                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: warehouse,
                          decoration: InputDecoration(
                              hintText: 'Warehouse',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: weight,
                          decoration: InputDecoration(
                              hintText: 'Weight',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),
                
                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: mrp,
                          decoration: InputDecoration(
                              hintText: 'MRP',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: valuation_per_unit,
                          decoration: InputDecoration(
                              hintText: 'Valuation Per Unit',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
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
                        prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),

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
                        prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),

                    )
                ),
                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: actual_units,
                          decoration: InputDecoration(
                              hintText: 'Actual Units',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: total_valuation,
                          decoration: InputDecoration(
                              hintText: 'Total Valuation',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )
                              ),
                              prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
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
                  String uBrand = brand.text.toString();
                  String uFormat = format.text.toString();
                  String uVariant = variant.text.toString();
                  String uDescriiption = description.text.toString();
                  String uMfgMonth = mfg_month.text.toString();
                  String uMfgYear = mfg_month.text.toString();
                  String uExpMonth = exp_month.text.toString();
                  String uExpYear = exp_year.text.toString();
                  String uWarehouse = warehouse.text.toString();
                  String uWeight = weight.text.toString();
                  String uMrp = mrp.text.toString();
                  String uValuationPerUnit = valuation_per_unit.text.toString();
                  String uSystemUnit = system_unit.text.toString();
                  String uCalculation = calculation.text.toString();
                  String uActualUnit = actual_units.text.toString();
                  String uTotalValuation = total_valuation.text.toString();
                  dbHelper!.insert(
                      AuditEntriesModel(
                    brandId: uBrand,
                    formatId: uFormat,
                        variantId: uVariant,
                        productId: uDescriiption,
                        mfgMonth: uMfgMonth,
                        mfgYear: uMfgYear,
                        expMonth: uExpMonth,
                        expYear: uExpYear,
                        warehouseId: uWarehouse,
                        weight: uWeight,
                        mrp: uMrp,
                        valuationPerUnit: uValuationPerUnit,
                        systemUnit: uSystemUnit,
                        calculationArr: uCalculation,
                        actualUnit: uActualUnit,
                        totalStockValue: uTotalValuation
                      )
                  ).then((value) {
                    print('Data added Successfully');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AuditEntries()));
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                }, child: Text(
                    'Save'
                ))
              ],
            )
        ),
      ),
    );
  }
}