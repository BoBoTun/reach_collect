import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';

import '../../../data/model/muac_model.dart';
import '../../../data/model/pnu_model.dart';
import '../../../network/presistance/SQLiteHelper.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/preference_keys.dart';
import '../../../utils/share_preference.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_dropdown_widget.dart';
import '../../../widgets/custom_radio.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/month_picker.dart';
import '../../../widgets/textfield_widget.dart';
import '../../home_screen.dart';

class EditPNU extends StatefulWidget {
  const EditPNU({super.key, required this.reachCollectVo});
  final PNUVo reachCollectVo;
  @override
  State<EditPNU> createState() => _EditPNUState();
}

class _EditPNUState extends State<EditPNU> {

  //data var
  String date = '';
  String disability = 'Yes';
  String gender = 'Yes';
  String disabled = 'Yes';
  String relocation = 'Yes';
  String bcgValue = '';
  String isPrevent = 'Yes';
  String handOverValue = '';

  String reportingPeriod = '';
  String todayDateString = '';
  String swelling = '';
  String patientType = '';

  String clinic = 'ဆေးခန်း';
  String referGo = 'Yes';
  String amclin = 'အလုံး';

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  TextEditingController villageNameController = TextEditingController();
  TextEditingController volunteerNameController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController treatmentPeriodController = TextEditingController();
  TextEditingController amoSislinController = TextEditingController();
  TextEditingController saltPackageContoller = TextEditingController();
  TextEditingController zincSulphateWholeController = TextEditingController();
  TextEditingController paracetamolWholeController = TextEditingController();

  late List<String> selectedValueList;


  final SQLiteHelper helper = SQLiteHelper();

  final TextEditingController orgController = TextEditingController();
  final TextEditingController townshipLocalController = TextEditingController();

  String? _selectedKey;
  String? _selectedItem;

  String selectSymptomsList = '';
  String selectTypeOfDiseaseList = '';

  List trementList = [];
  String trement = '';

  @override
  void initState() {
    super.initState();

    date = widget.reachCollectVo.date ?? '';
    gender = widget.reachCollectVo.sex ?? 'ကျား';
    disabled = widget.reachCollectVo.disabled ?? 'Yes';
    relocation = widget.reachCollectVo.relocation ?? 'Yes';
    handOverValue = widget.reachCollectVo.referPlace ?? '';
    clinic = widget.reachCollectVo.clinic ?? 'ဆေးခန်း';

    villageNameController.text = widget.reachCollectVo.villageName ?? '';
    date = widget.reachCollectVo.date ?? '';
    nameController.text = widget.reachCollectVo.name ?? '';

    remarkController.text = widget.reachCollectVo.remark ?? '';
    volunteerNameController.text = widget.reachCollectVo.volunteerName ?? '';

    reportingPeriod = widget.reachCollectVo.reportingPeroid ?? '';

    ageController.text = widget.reachCollectVo.age ?? '';

    isPrevent = widget.reachCollectVo.refer ?? 'Yes';
    referGo = widget.reachCollectVo.referGo ?? 'Yes';

    patientType = widget.reachCollectVo.kofPatient ?? '';
    treatmentPeriodController.text = widget.reachCollectVo.treatmentPeriod ?? '';


    DateTime todayDate = DateTime.now();
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    orgController.text = widget.reachCollectVo.orgName ?? '';
    townshipLocalController.text = widget.reachCollectVo.townshipLocalName ?? '';

    _selectedKey = widget.reachCollectVo.stateName ?? '';
    _selectedItem = widget.reachCollectVo.townshipName ?? '';

    selectSymptomsList = widget.reachCollectVo.symptomsList ?? '';
    selectTypeOfDiseaseList = widget.reachCollectVo.diseaseList ?? '';

    print("sy string :: $selectTypeOfDiseaseList");
   List symList =  selectTypeOfDiseaseList.split('||');
   print("symList $symList");

    trement = widget.reachCollectVo.treatment ?? '';
   trementList = trement.split('||');


    amclin = trementList[0];
   amoSislinController.text = trementList[1];
   saltPackageContoller.text = trementList[2];
   zincSulphateWholeController.text = trementList[3];
   paracetamolWholeController.text = trementList[4];

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
                "Pnu&Diarr",
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

                //section two
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),

                //pre session
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
                          clinic = value;
                        }, options: AppConstants.clinicList, currentValue: clinic.isEmpty ? AppConstants.clinicList[0] : clinic,),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ကျေးရွာအမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ကျေးရွာအမည်', 1, villageNameController,10000),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'စေတနာ့ဝန်ထမ်းအမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('စေတနာ့ဝန်ထမ်းအမည်', 1, volunteerNameController,10000),
                      ],
                    ),

                    //channel
                  ],
                ),
                //pre session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reporting Period',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MonthPicker(dateString: (dateString) {
                          reportingPeriod = dateString;
                        },
                          updateDateString: reportingPeriod,
                        ),
                      ],
                    ),
                    //channel
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //line
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),

                const SizedBox(
                  height: 20,
                ),

                //Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ရက်စွဲ',
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
                    //Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'အမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('အမည်', 1, nameController,10000),
                      ],
                    ),
                    //Age
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'အသက်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('အသက်', 1, ageController,3),
                      ],
                    ),

                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                //Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Gender
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ကျား/မ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  gender = value;
                                },
                                activeValue: gender, radioList: ['ကျား','မ'],
                              )),
                        ],
                      ),
                    ),
                    //Disabled
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'မသန်စွမ်းသူ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  disabled = value;
                                },
                                activeValue: disabled, radioList: const ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
                    //Relocation
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ရွှေ့ပြောင်း နေထိုင်သူ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  relocation = value;
                                },
                                activeValue: relocation, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //Row 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'လူနာအမျိုးအစား',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) { patientType = value; }, options: AppConstants.patientTypeList, currentValue: patientType,),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ရောဂါလက္ခဏာ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                          child:MultiSelectDropdown.simpleList(
                            list: AppConstants.symptomsList,
                            initiallySelected: selectSymptomsList.split('||'),
                            onChange: (newList) {
                              // your logic
                              selectSymptomsList = newList.join('||');
                            },
                            includeSearch: true,
                            includeSelectAll: true,
                            isLarge: false, // Modal size will be a little large
                            // Give a definite width when rendering this widget in a row
                            width: 250, // Must be a definite number
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ရောဂါအမျိုးအစား',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                          child:MultiSelectDropdown.simpleList(
                            list: AppConstants.typeOfDiseaseList,
                            initiallySelected: selectTypeOfDiseaseList.split('||'),
                            onChange: (newList) {
                              // your logic
                              selectTypeOfDiseaseList = newList.join('||');
                            },
                            includeSearch: true,
                            includeSelectAll: true,
                            isLarge: true, // Modal size will be a little large
                            // Give a definite width when rendering this widget in a row
                            width: 250, // Must be a definite number
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),



                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //Row 4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ကုသမှု',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'အမောက်စီစလင်',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  amclin = value;
                                },
                                activeValue: amclin, radioList: ['အလုံး','အရည်'],
                              )),
                          halfInputBox('အရေအတွက်', amoSislinController,10000),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 50,
                              width: 200,
                              child: Text('')),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ဓာတ်ဆား (ထုပ်)',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အရေအတွက်', saltPackageContoller,10000),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 50,
                              width: 200,
                              child: Text('')),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ဇင့်ဆာလဖိတ် (လုံး)',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အရေအတွက်', zincSulphateWholeController,10000),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 50,
                              width: 200,
                              child: Text('')),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ပါရာစီတမော (လုံး)',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),

                          halfInputBox('အရေအတွက်', paracetamolWholeController,10000),
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                //Row 4.5
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ကုသသည့်ကာလ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ကုသသည့်ကာလ', 1, treatmentPeriodController,3),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ညွှန်းပို့မှု',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  isPrevent = value;
                                },
                                activeValue: isPrevent, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),

                    SizedBox(
                        width: 250),
                  ],
                ),


                const SizedBox(
                  height: 40,
                ),
                //Row 5
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //dorp down
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ညွှန်းပို့သည့်နေရာ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) { handOverValue = value; }, options: AppConstants.handoverList, currentValue: handOverValue,),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ညွှန်းပို့ရာသို့ သွား/မသွား',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  referGo = value;
                                },
                                activeValue: referGo, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'မှတ်ချက်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('မှတ်ချက်', 3, remarkController,10000),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 600,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                            buttonText: 'Cancel',
                            type: 1,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(width: 20,),
                        ButtonWidget(
                            buttonText: 'Save',
                            type: 0,
                            onPressed: () {
                              {
                                if (nameController.text.isEmpty||
                                    ageController.text.isEmpty ||
                                    villageNameController.text.isEmpty ||
                                    volunteerNameController.text.isEmpty ||
                                    treatmentPeriodController.text.isEmpty ||
                                    reportingPeriod.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Center(
                                        child: Text('Sorry!! Please input empty fields'),
                                      )));
                                } else {
                                  //Check Validation for Age
                                  var age = int.parse(ageController.text);
                                  if (age > 0 && age < 101) {
                                    String trementValue = "$amclin||${amoSislinController.text}||${saltPackageContoller.text}||${zincSulphateWholeController.text}||${paracetamolWholeController.text}";
                                    PNUVo dataVo = PNUVo(
                                        id: widget.reachCollectVo.id,
                                        tableName: AppConstants.pnuTable,
                                        orgName: orgController.text,
                                        stateName: _selectedKey,
                                        townshipName: _selectedItem,
                                        townshipLocalName: townshipLocalController.text,
                                        clinic: clinic,
                                        villageName: villageNameController.text,
                                        volunteerName: volunteerNameController.text,
                                        reportingPeroid: reportingPeriod,
                                        date: date,
                                        name: nameController.text,
                                        age: ageController.text,
                                        sex: gender,
                                        disabled: disabled,
                                        relocation: relocation,
                                        kofPatient: patientType,
                                        symptomsList: selectSymptomsList,
                                        diseaseList: selectTypeOfDiseaseList,
                                        treatment: trementValue,
                                        treatmentPeriod: treatmentPeriodController.text,
                                        refer: isPrevent,
                                        referPlace: handOverValue,
                                        referGo: referGo,
                                        remark: remarkController.text,
                                        createDate: todayDateString,
                                        updateDate: todayDateString);
                                    //Add To DB

                                    try {
                                      // PreferenceManager.setString(CLINIC, clinicTeamController.text);
                                      // PreferenceManager.setString(CHANNEL, channel);
                                      // PreferenceManager.setString(REPORT_PERIOD, reportingPeriod);
                                      //  DatabaseProvider provider = DatabaseProvider.db;
                                      // provider.insertACNDataToDB(dataVo);
                                      helper.updatePNUInto(dataVo);

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  HomeScreen(indexOfTab: 2, selectedSideIndex: 1,)));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Center(
                                            child: Text('Something wrong!!'),
                                          )));
                                    }

                                    //End add to DB

                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Center(
                                          child: Text('Age should be between 1 to 100 years !!!'),
                                        )));

                                  }

                                }
                              }

                            }
                        ),
                      ],
                    ),

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container inputBox(
      String title, int maxlines, TextEditingController controller, int limit) {
    return Container(
      height: maxlines == 1 ? 50 : 100,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: controller == ageController || controller == treatmentPeriodController
            ? TextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(limit),
          ],
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        )
            : TextField(
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),

      ),
    );
  }

  Container halfInputBox(
      String title, TextEditingController controller, int limit) {
    return Container(
      height: 50,
      width: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(limit),
          ],
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),

      ),
    );
  }
}