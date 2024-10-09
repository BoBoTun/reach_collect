import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/src/runtime/data_class.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modern_dialog/dialogs/vertical.dart';
import 'package:modern_dialog/modern_dialog.dart';
import 'package:moor2csv/moor2csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reach_collect/network/presistance/SQLiteHelper.dart';
import 'package:reach_collect/network/presistance/database_table.dart';
import 'package:reach_collect/screens/export_screen.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/custom_button.dart';

import '../data/model/anc_model.dart';
import '../data/model/delivery_model.dart';
import '../data/model/srh_model.dart';

class SidebarListItemView extends StatefulWidget {
  const SidebarListItemView({super.key, required this.sideItemSelected, required this.selectedIndex});

  final Function(int) sideItemSelected;
  final int selectedIndex;

  @override
  State<SidebarListItemView> createState() => _SidebarListItemViewState();
}

class _SidebarListItemViewState extends State<SidebarListItemView> {
  int _selectedIndex = 0;
  List<String> items = ['Maternal and Reproductive Health', 'Child Health','Infectious Disease', 'Aggregated Reporting'];
  final SQLiteHelper helper = SQLiteHelper();
  List<List<dynamic>> _data = [];

  Future<String> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    String filePath = "";
    if (result == null) return filePath;

    PlatformFile file = result.files.single;

    filePath = file.path ?? "";

    return filePath;
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

  void _exportCSV(int type) async {
    final filePath = await _pickFolder();
    // Do something with the desktop directory
    if (filePath != null) {
      DateTime todayDate = DateTime.now();

      String today = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);
      String name = "";
      if (type == 0) {
        name = AncRegisterTable.TABLE_NAME;
      }else if (type == 1){
        name = DeliveryTable.TABLE_NAME;
      }else if (type == 2){
        name = SRHTable.TABLE_NAME;
      }else if (type == 3){
        name = EPITable.TABLE_NAME;
      }else if (type == 4){
        name = MUACTable.TABLE_NAME;
      }else{
        name = PNUTable.TABLE_NAME;
      }
      final path =
          "$filePath\\$name-$today.csv";
      print(path);
      final File file = File(path);
      if (type == 0) {
        //Type ANC
        try {
          String csvData;
          //String savePath = path;
          helper.getAllANCForExport().then((value) async => {
                csvData = ListToCsvConverter().convert(value),
                await file.writeAsString(csvData)
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
      } else if (type == 1) {
        //Type Delivery

        try {
          String csvData;
          //String savePath = path;
          helper.getAllDeliveryForExport().then((value) async => {
                csvData = ListToCsvConverter().convert(value),
                await file.writeAsString(csvData)
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
      }else if (type == 3){
        // Type SRH

        try {
          String csvData;
          //String savePath = path;
          helper.getAllEPIForExport().then((value) async => {
                csvData = ListToCsvConverter().convert(value),
                await file.writeAsString(csvData)
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
      }else if (type == 4){
        // Type SRH

        try {
          String csvData;
          //String savePath = path;
          helper.getAllMUACyForExport().then((value) async => {
            csvData = ListToCsvConverter().convert(value),
            await file.writeAsString(csvData)
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
      }else if (type == 5){
        // Type SRH

        try {
          String csvData;
          //String savePath = path;
          helper.getAllPNUForExport().then((value) async => {
            csvData = ListToCsvConverter().convert(value),
            await file.writeAsString(csvData)
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
    } else {
      print('Unable to access desktop directory.');
    }
  }

  void  _importFile() async {

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
              const Text('Import Success'),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  widget.sideItemSelected(_selectedIndex);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.selectedIndex;
    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    widget.sideItemSelected(index);
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? AppTheme.thirdColor
                          : AppTheme.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3.0,
                            spreadRadius: 3.0,
                            color: AppTheme.thirdColor.withOpacity(0.2))
                      ]),
                  child: Center(
                      child: Text(
                    items[index],
                    style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              );
            })),
      ),
      //Import - Export
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            buttonHeight: 40,
            label: 'Import',
            iconName: AppTheme.importImg,
            width: 100,
            onPressed: () {

              _importFile();

            },
          ),
          CustomButton(
            buttonHeight: 40,
            label: 'Export',
            iconName: AppTheme.kExportLogo,
            width: 100,
            onPressed: () async {

              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  const Export()));
              /*
              ModernDialog.showVerticalDialog(
                context,
                content: const Text("Export For"),
                dismissibleDialog: true,
                // your custom buttons
                buttons: [
                  DialogButton(
                    title: "ANC",
                    onPressed: () => {_exportCSV(0)},
                    color: AppTheme.secondaryColor,
                  ),
                  DialogButton(
                    title: "Delivery",
                    onPressed: () => {_exportCSV(1)},
                    color: AppTheme.secondaryColor,
                  ),
                  DialogButton(
                    title: "SRH",
                    onPressed: () => {_exportCSV(2)},
                    color: AppTheme.secondaryColor,
                  ),
                  DialogButton(
                    title: "EPI",
                    onPressed: () => {_exportCSV(3)},
                    color: AppTheme.secondaryColor,
                  ),
                  DialogButton(
                    title: "MUAC",
                    onPressed: () => {_exportCSV(4)},
                    color: AppTheme.secondaryColor,
                  ),
                  DialogButton(
                    title: "Pnu&Diarr",
                    onPressed: () => {_exportCSV(5)},
                    color: AppTheme.secondaryColor,
                  ),
                ],
              );

               */
            },
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      )
    ]);
  }
}
