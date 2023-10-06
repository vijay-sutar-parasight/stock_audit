import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/jsondata/GetBrandData.dart';
import 'package:stock_audit/models/brandmodel.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../db_handler.dart';
import '../appbar.dart';
import '../models/formatmodel.dart';
import 'formats.dart';

class AddFormat extends StatefulWidget{
  @override
  State<AddFormat> createState() => _AddFormat();
}

class _AddFormat extends State<AddFormat>{
  var brandId = TextEditingController();
  var formatName = TextEditingController();

  List<String> _brandList = [];
  List<GetBrandData> _brandMasterList = [];
  String selectedValue = "";

  Map<String, String> brandData = {};
  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
    getBrandData();
  }

  Future<void> getBrandData() async {
    _brandMasterList = await dbHelper!.getBrandListArray();
    for (int i = 0; i < _brandMasterList.length; i++) {

      // _brandList.add(_brandMasterList[i].brandName!);
      brandData[_brandMasterList[i].brandId!.toString()] = _brandMasterList[i].brandName!;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Add Format', {'icons' : Icons.menu}),
      body: Container(

          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
            child: Column(
              children: [
                TextField(
                    controller: formatName,
                    decoration: InputDecoration(
                        hintText: 'Format Name',
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
                DropdownSearch<String>(
                  popupProps: PopupProps.modalBottomSheet(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: brandData.values.toList(),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Brand",
                      hintText: "Select Brand",
                    ),
                  ),
                  onChanged: (val){
                    var key = brandData.keys.firstWhere((k)
                    => brandData[k] == val!, orElse: () => "");
                    brandId.text = key!;

                    setState(() {
                      selectedValue = val!;
                    });
                    print(brandId.text);
                  },
                  selectedItem: "",
                ),
                Container(height: 20),
                SizedBox(
                  width: constants.buttonWidth,
                  height: constants.buttonHeight,
                  child: ElevatedButton(onPressed: (){
                    String uBrandId = brandId.text.toString();
                    String uFormatName = formatName.text;
                    dbHelper!.insertFormat(
                        FormatModel(
                      brandId: uBrandId,
                      formatName: uFormatName
                        )
                    ).then((value) {
                      constants.Notification("Format Added Successfully");

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Formats()));
                      Navigator.pop(context,value);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  }, child: Text(
                      'Save'
                      ,style: TextStyle(color: Colors.white,fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        primary: constants.mainColor, //background color of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10)
                        ),
                      )
                  ),
                )
              ],
            ),
          )),
    );
  }
}