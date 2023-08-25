import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../audit/audit.dart';
import '../db_handler.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/formatmodel.dart';
import '../models/productmodel.dart';
import '../models/variantmodel.dart';
import '../models/warehousemodel.dart';
import 'descriptions.dart';

class UpdateDescription extends StatefulWidget{
  @override
  State<UpdateDescription> createState() => _UpdateDescription();
}

class _UpdateDescription extends State<UpdateDescription>{
  var productId = TextEditingController();
  var productName = TextEditingController();
  var itemNumber = TextEditingController();
  var companyId = TextEditingController();
  var formatId = TextEditingController();
  var brandId = TextEditingController();
  var variantId = TextEditingController();
  var warehouseId = TextEditingController();
  var systemUnit = TextEditingController();
  var valuationPerUnit = TextEditingController();
  var weight = TextEditingController();
  var mrp = TextEditingController();
  var combiType = TextEditingController();
  var pcsCases = TextEditingController();
  var totalStockValue = TextEditingController();
  var mfgDate = TextEditingController();
  var mfgMonth = TextEditingController();
  var mfgYear = TextEditingController();
  var expDate = TextEditingController();
  var expMonth = TextEditingController();
  var expYear = TextEditingController();
  var recordId;

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {

    final updateProduct = ModalRoute.of(context)!.settings.arguments as ProductModel;
    itemNumber.text = updateProduct.itemNumber!;
    productName.text = updateProduct.productName!;
    companyId.text = updateProduct.companyId!;
    brandId.text = updateProduct.brandId!;
    formatId.text = updateProduct.formatId!;
    variantId.text = updateProduct.variantId!;
    warehouseId.text = updateProduct.warehouseId!;
    mfgMonth.text = updateProduct.mfgMonth!;
    mfgYear.text = updateProduct.mfgYear!;
    expMonth.text = updateProduct.expMonth!;
    expYear.text = updateProduct.expYear!;
    weight.text = updateProduct.weight!;
    mrp.text = updateProduct.mrp!;
    systemUnit.text = updateProduct.systemUnit!;
    valuationPerUnit.text = updateProduct.valuationPerUnit!;
    combiType.text = updateProduct.combiType!;
    pcsCases.text = updateProduct.pcsCases!;
    totalStockValue.text = updateProduct.totalStockValue!;

    recordId = updateProduct.productId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Description')
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
                        controller: itemNumber,
                        decoration: InputDecoration(
                          hintText: 'Item Number',
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
                          controller: productName,
                          decoration: InputDecoration(
                            hintText: 'Description Name',
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
                          controller: companyId,
                          decoration: InputDecoration(
                            hintText: 'Select Company',
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
                          controller: brandId,
                          decoration: InputDecoration(
                            hintText: 'Select Brand',
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
                        controller: formatId,
                        decoration: InputDecoration(

                          hintText: 'Select Format',
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
                          controller: variantId,
                          decoration: InputDecoration(
                            hintText: 'Select Variant',
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
                          controller: warehouseId,
                          decoration: InputDecoration(
                            hintText: 'Select Warehouse',
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
                          controller: mfgMonth,
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
                          controller: mfgYear,
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
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: expMonth,
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
                  ],
                ),

                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: expYear,
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
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),

                    )
                ),
                Container(height: 11),
                TextField(
                    controller: systemUnit,
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
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: valuationPerUnit,
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
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: combiType,
                          decoration: InputDecoration(
                            hintText: 'Combi Type',
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
                          controller: pcsCases,
                          decoration: InputDecoration(
                            hintText: 'PCS/Cases',
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
                          controller: totalStockValue,
                          decoration: InputDecoration(
                            hintText: 'Total Stock Value',
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
                  String uItemNumber = itemNumber.text.toString();
                  String uDescriptionName = productName.text.toString();
                  String uCompanyId = companyId.text.toString();
                  String uBrandId = brandId.text.toString();
                  String uFormatId = formatId.text.toString();
                  String uVariantId = variantId.text.toString();
                  String uWarehouseId = warehouseId.text.toString();
                  String uMfgMonth = mfgMonth.text.toString();
                  String uMfgYear = mfgYear.text.toString();
                  String uExpMonth = expMonth.text.toString();
                  String uExpYear = expYear.text.toString();
                  String uWeight = weight.text.toString();
                  String uMrp = mrp.text.toString();
                  String uSystemUnit = systemUnit.text.toString();
                  String uValuationPerUnit = valuationPerUnit.text.toString();
                  String uCombiType = combiType.text.toString();
                  String uPcsCases = pcsCases.text.toString();
                  String uTotalStockValue = totalStockValue.text.toString();
                  dbHelper!.updateProduct(
                      ProductModel(
                          productId: recordId,
                          itemNumber: uItemNumber,
                          productName: uDescriptionName,
                          companyId: uCompanyId,
                          brandId: uBrandId,
                          formatId: uFormatId,
                          variantId: uVariantId,
                          warehouseId: uWarehouseId,
                          mfgMonth: uMfgMonth,
                          mfgYear: uMfgYear,
                          expMonth: uExpMonth,
                          expYear: uExpYear,
                          weight: uWeight,
                          mrp: uMrp,
                          valuationPerUnit: uValuationPerUnit,
                          systemUnit: uSystemUnit,
                          combiType: uCombiType,
                          pcsCases: uPcsCases,
                          totalStockValue: uTotalStockValue
                      )
                  ).then((value) {
                    print('Data added Successfully');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Descriptions()));
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