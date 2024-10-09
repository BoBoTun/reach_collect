import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/network/presistance/database_table.dart';

import '../network/presistance/SQLiteHelper.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/preference_keys.dart';
import '../utils/share_preference.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_dropdown_widget.dart';
import '../widgets/date_picker.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class Export extends StatefulWidget {
  const Export({super.key});

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {


  List<String> orgList = [];
  List<String> townshipList = [];
  List<String> clinicList = [];

  String selectedOrg = '';
  String selectedTownship = '';
  String selectedClinic = '';


  String? _selectedKey;
  String? _selectedItem;

  String? _selectedKeyTownship;
  String? _selectedItemTownship;

  String date = '';



  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orgList.add('All');
    townshipList.add('All');
    clinicList.add('All');

    selectedOrg = orgList[0];
    selectedTownship = townshipList[0];
    selectedClinic = clinicList[0];

    orgList.addAll(PreferenceManager.getStringList(ORG_LIST) ?? []);
    clinicList.addAll(AppConstants.clinicList);

    _removeDuplicates();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: AppTheme.secondaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
            children: [
              Image.asset(
                AppTheme.kInsuranceLogo,
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 30,
              ),
              const Text(
                "Export",
                style: AppTheme.navigationTitleStyle,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AppTheme.kBackIcon,
                  width: 60,
                  height: 60,
                )),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.primaryColor),
        child: Padding(
          padding:
          const EdgeInsets.only(left: 80, top: 30, bottom: 14, right: 80),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const  Text(
                              'Export For',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                                  hint: const Text('Please Select'),
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                  underline: Container(
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedKey = newValue;
                                      _selectedItem = null;
                                    });
                                  },
                                  items: AppConstants.reachCollectList.keys
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
                          'Select Form',
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
                              hint: const Text('Please Select'),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              underline: Container(
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedItem = newValue;
                                });
                              },
                              items: AppConstants.reachCollectList[_selectedKey]!
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 20,
                ),
                //pre session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Organization',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {

                           selectedOrg = value;


                        }, options: orgList, currentValue: selectedOrg,),
                      ],
                    ),

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
                              width: 250,
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
                                  value: _selectedKeyTownship,
                                  //icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  elevation: 16,
                                  hint: Text('Please Select'),
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                  underline: Container(
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedKeyTownship = newValue;
                                      _selectedItemTownship = null;
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

                    _selectedKeyTownship != null ? Column(
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
                          width: 250,
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
                              value: _selectedItemTownship,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 30,
                              elevation: 16,
                              hint: Text('Please Select'),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              underline: Container(
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedItemTownship = newValue;
                                });
                              },
                              items: AppConstants.stateAndTownshipList[_selectedKeyTownship]!
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


                  ],

                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Clinic',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {

                          selectedClinic = value;


                        }, options: clinicList, currentValue: selectedClinic,),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            date = dateString;
                          },
                          updateDateString: date,
                        ),
                      ],
                    ),


                    const SizedBox(width: 200,)

                  ],

                ),

                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ButtonWidget(
                      buttonText: 'Export',
                      onPressed: () {

                        _exportCSV(0);

                      }),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      // User canceled the picker
      return "";
    } else {
      return selectedDirectory;
    }
  }

  // Remove duplicate strings from the list
  void _removeDuplicates() {
    setState(() {
      orgList = orgList.toSet().toList();
    });
  }

  void _exportCSV(int type) async {
    final filePath = await _pickFolder();
    // Do something with the desktop directory
    String csvData;
    List<int> utf8Bom;
    List<int> encodedData;
    List<int> finalData;
    if (_selectedItem != null) {
      Map<String, int>? foundIndex = getIndexFromMap(AppConstants.reachCollectList, _selectedItem!);
      print("Index 1: ${foundIndex?.keys.first} Index 2: ${foundIndex?.values.first}");

      if (filePath != null) {
        DateTime todayDate = DateTime.now();

        String today = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);
        String name = "";
        if (_selectedKey == 'RMNCH'){
          if (foundIndex?.values.first == 0) {
            name = AncRegisterTable.TABLE_NAME;
            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            //Type ANC
            try {
              //String savePath = path;
              helper.getAllANCForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
               utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
               encodedData = utf8.encode(csvData),
               finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)//file.writeAsString(encodedData)

              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }
          else if (foundIndex?.values.first == 1){
            name = DeliveryTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            //Type Delivery

            try {
              String csvData;
              //String savePath = path;
              helper.getAllDeliveryForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }
          else{

            name = SRHTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            //Type SRH

            try {
              String csvData;
              //String savePath = path;
              helper.getAllSRHForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }

        }else if (_selectedKey == 'Under5'){
          if (foundIndex?.values.first == 0){
            name = EPITable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            try {
              String csvData;
              //String savePath = path;
              helper.getAllEPIForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }
          else if (foundIndex?.values.first == 1){
            name = MUACTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            // Type SRH

            try {
              String csvData;
              //String savePath = path;
              helper.getAllMUACyForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }
          else{
            name = PNUTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            // Type SRH

            try {
              String csvData;
              //String savePath = path;
              helper.getAllPNUForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }
        }else{

          if (foundIndex?.values.first == 0){
            name = ConsultationTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            // Type Consultation

            try {
              String csvData;
              //String savePath = path;
              helper.getAllConsultationForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }else if (foundIndex?.values.first == 1){
            name = DistributionTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            // Type Distribution

            try {
              String csvData;
              //String savePath = path;
              helper.getAllDistributionForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }else if (foundIndex?.values.first == 1){
            name = HETable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            // Type HE

            try {
              String csvData;
              //String savePath = path;
              helper.getAllHEForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }else{
            name = ReferralTable.TABLE_NAME;

            final path =
                "$filePath\\$name-$today.csv";
            print(path);
            final File file = File(path);

            // Type Referral

            try {
              String csvData;
              //String savePath = path;
              helper.getAllReferralForExport().then((value) async => {
                csvData = const ListToCsvConverter().convert(value),
                utf8Bom = [0xEF, 0xBB, 0xBF], // UTF-8 BOM
                encodedData = utf8.encode(csvData),
                finalData = utf8Bom + encodedData,
                await file.writeAsBytes(finalData)
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                    child: Text('Export data successfully! At $path'),
                  )));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Center(
                    child: Text('Export Fail!!'),
                  )));
            }

          }
        }

      } else {
        print('Unable to access desktop directory.');
      }



    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
          content: Center(
            child: Text('Please select you want to export form.'),
          )));
    }

  }

  Map<String, int>? getIndexFromMap(Map<String, List<String>> map, String value) {
    for (var entry in map.entries) {
      int index = entry.value.indexOf(value);
      if (index != -1) {
        return {entry.key: index};
      }
    }
    return null; // Return null if the value is not found
  }


}
