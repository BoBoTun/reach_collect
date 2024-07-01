import 'dart:convert';
import 'dart:io';

//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reach_collect/screens/home_screen.dart';
import 'package:reach_collect/utils/app_constant.dart';
import 'package:reach_collect/utils/preference_keys.dart';
import 'package:reach_collect/utils/share_preference.dart';
import 'package:reach_collect/widgets/button_widget.dart';
import 'package:reach_collect/widgets/custom_bar_widget.dart';
import 'package:reach_collect/widgets/custom_dropdown_widget.dart';

import '../data/model/anc_model.dart';
import '../data/model/delivery_model.dart';
import '../data/model/srh_model.dart';
import '../network/presistance/SQLiteHelper.dart';
import '../utils/app_styles.dart';
import '../widgets/textfield_widget.dart';

class PreFilledScreen extends StatefulWidget {
  const PreFilledScreen({super.key});

  @override
  State<PreFilledScreen> createState() => _PreFilledScreenState();
}

class _PreFilledScreenState extends State<PreFilledScreen> {
  final TextEditingController orgController = TextEditingController();
  final TextEditingController townshipLocalController = TextEditingController();


  String? _selectedKey;
  String? _selectedItem;
  List<List<dynamic>> _data = [];
  final SQLiteHelper helper = SQLiteHelper();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
               CustomBarWidget(),

              const SizedBox(
                height: 73,
              ),
              //section one
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Organization *',
                    style: TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5.0,
                        spreadRadius: 5.0,
                        color: AppTheme.shadowColor)
                  ]),
                    child: TextFieldWidget(
                      maxLength: 300,
                      maxLines: 1,
                      hintText: "Organization name",
                      obscureText: false,
                      controller: orgController),
                  ),
                ],
              ),
              const SizedBox(
                width: 126,
              ),
          
              const SizedBox(
                height: 73,
              ),
          
              //section two
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const  Text(
                        'State/Region *',
                        style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          isExpanded: true,
                value: _selectedKey,
                //icon: Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                hint: Text('Please Select'),
                style: const TextStyle(fontSize: 16, color: Colors.black),
                underline: Container(
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedKey = newValue;
                    _selectedItem = null;
                  });
                },
                items: AppConstants.stateAndTownshipList.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
      ),
    ),
                    ],
                  ),
                    ],
                  ),
                const SizedBox(
                    width: 126,
                  ),

                  _selectedKey != null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
                      const Text(
                        'Township(MIMU) *',
                        style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                     Container(
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          isExpanded: true,
                      value: _selectedItem,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      hint: Text('Please Select'),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      underline: Container(
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      items: AppConstants.stateAndTownshipList[_selectedKey]!
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
      ),
    ),

                      
                    ],
                  ) : Container(),

                  const SizedBox(
                    width: 126,
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Township(Local)',
                        style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //DropdownListView(),
                      Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                            color: AppTheme.shadowColor)
                      ]),
                        child: TextFieldWidget(
                          maxLength: 300,
                          maxLines: 1,
                          hintText: "Township Local",
                          obscureText: false,
                          controller: townshipLocalController),
                      ),
                    ],
                  ),
                ],
              ),
          
              //sizebox
              const SizedBox(
                height: 60,
              ),

              
              //button
              SizedBox(
                height: 50,
                width: 300,
                child: ButtonWidget(
                    buttonText: 'Continue',
                    onPressed: () {

                      if (orgController.text.isEmpty || _selectedKey == null || _selectedItem == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Center(
                              child: Text('Sorry!! Please input empty fields'),
                            )));
                          }else{

                            PreferenceManager.setString(ORG, orgController.text);
                            PreferenceManager.setString(STATE, _selectedKey ?? "");
                            PreferenceManager.setString(REGION, _selectedItem ?? "");
                            PreferenceManager.setString(REGION_LOCAL, townshipLocalController.text);

                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (_) => HomeScreen(indexOfTab: 0, selectedSideIndex: 0,),
                      ));
                        }
                    }),
              )
            ],
          ),
        ));
  }

  void  _pickFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    String filePath = "";
    if (result == null) return;

    PlatformFile file = result.files.single;

    // filePath = file.path ?? "";

    //return filePath;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });



    bool isAnc = file.name.contains('AncRegisterTable');
    bool isDelivery = file.name.contains('DeliveryTable');
    bool isSrh = file.name.contains('SRHTable');

    print("FileName :: ${file.name} And is Delivery :: $isDelivery");

    fields.removeAt(0);
    for (var item in fields){
      if (isAnc){
        //Add To DB
        ANCVo dataVo = ANCVo(
            orgName: item[1].toString(),
            stateName: item[2].toString(),
            townshipName: item[3].toString(),
            townshipLocalName:item[4].toString(),
            clinic: item[5].toString(),
            channel: item[6].toString(),
            reportingPeroid: item[7].toString(),
            date: item[8].toString(),
            name: item[9].toString(),
            age: item[10].toString(),
            disability: item[11].toString(),
            idp: item[12].toString(),
            gestational: item[13].toString(),
            gravida: item[14].toString(),
            parity: item[15].toString(),
            td: item[16].toString(),
            findings: item[17].toString(),
            treatment: item[18].toString(),
            attended: item[19].toString(),
            outcome: item[20].toString(),
            remark: item[21].toString(),
            createDate: item[22].toString(),
            updateDate: item[23].toString());

        try {
          //  DatabaseProvider provider = DatabaseProvider.db;
          // provider.insertACNDataToDB(dataVo);
          helper.insertACNDataToDB(dataVo,true);

        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
              content: Center(
                child: Text('Something wrong!!'),
              )));
        }
      }
      if (isDelivery){
        DeliveryVo dataVo = DeliveryVo(
            orgName: item[1].toString(),
            stateName: item[2].toString(),
            townshipName:item[3].toString(),
            townshipLocalName:item[4].toString(),
            clinic: item[5].toString(),
            channel: item[6].toString(),
            reportingPeroid: item[7].toString(),
            date: item[8].toString(),
            name: item[9].toString(),
            age: item[10].toString(),
            disability: item[11].toString(),
            iDP: item[12].toString(),
            gestational: item[13].toString(),
            gravida: item[14].toString(),
            tDComplete: item[15].toString(),
            birthType: item[16].toString(),
            birthWeight: item[17].toString(),
            neonatal: item[18].toString(),
            breastfeeding: item[19].toString(),
            treatment: item[20].toString(),
            attended: item[21].toString(),
            outcome: item[22].toString(),
            remark: item[23].toString(),
            createDate: item[24].toString(),
            updateDate: item[25].toString()
        );

        try {
          helper.insertDeliveryDataToDB(dataVo,true);

        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
              content: Center(
                child: Text('Something wrong!!'),
              )));
        }

      }

      if (isSrh) {
        SRHVo dataVo = SRHVo(
            orgName: item[1].toString(),
            stateName: item[2].toString(),
            townshipName:item[3].toString(),
            townshipLocalName:item[4].toString(),
            clinic: item[5].toString(),
            channel: item[6].toString(),
            reportingPeroid: item[7].toString(),
            date: item[8].toString(),
            name: item[9].toString(),
            age: item[10].toString(),
            sex: item[11].toString(),
            disability: item[12].toString(),
            iDP: item[13].toString(),
            serviceType: item[14].toString(),
            firstReach: item[15].toString(),
            fpCommodity: item[16].toString(),
            quantity: item[17].toString(),
            fnpDiagnosis: item[18].toString(),
            treatment: item[19].toString(),
            attended: item[20].toString(),
            outcome: item[21].toString(),
            remark: item[22].toString(),
            createDate: item[23].toString(),
            updateDate: item[24].toString());

        try {
          //DatabaseProvider provider = DatabaseProvider.db;
          helper.insertSRHDataToDB(dataVo,true);

        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
              content: Center(
                child: Text('Something wrong!!'),
              )));
        }
      }


    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is a typical dialog.'),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
