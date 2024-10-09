import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/widgets/multi_radio.dart';

import '../../data/model/anc_model.dart';
import '../../network/presistance/SQLiteHelper.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_styles.dart';
import '../../utils/preference_keys.dart';
import '../../utils/share_preference.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_radio.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/male_female_radio.dart';
import '../../widgets/month_picker.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/tdDropdown.dart';
import '../home_screen.dart';

class MalariaRegister extends StatefulWidget {
  const MalariaRegister({super.key});

  @override
  State<MalariaRegister> createState() => _MalariaRegisterState();
}

class _MalariaRegisterState extends State<MalariaRegister> {
  //data var
  String date = '';
  String disabled = 'Yes';
  String idp = 'Yes';
  String attendedby = '';
  String outcome = '';
  String reportingPeriod = '';
  String tdSelectString = '';
  String tdSelectedDate = '';
  String channel = 'ဆေးခန်း';
  String todayDateString = '';
  String ancFour = 'Yes';
  String sex = 'Male';
  String relocation = 'Yes';
  String pregnant = 'Yes';
  String treatment = '၂၄ နာရီအတွင်း';

  bool _isCheckedOne = false;
  bool _isCheckedTwo = false;
  bool _isCheckedThree = false;
  bool _isCheckedFour = false;

  bool _isCheckedNormal = false;
  bool _isCheckedStrong = false;


  TextEditingController nameController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gestationalWeekController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  TextEditingController parityController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController villageNameController = TextEditingController();
  TextEditingController nOfANCVisitController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController act24Controller = TextEditingController();


  final SQLiteHelper helper = SQLiteHelper();


  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];
    tdSelectedDate = "${todayDate.toLocal()}".split(' ')[0];
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    //clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
   // channel = AppConstants.channelList[0];

    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    attendedby = AppConstants.attandedList[0];
    outcome = AppConstants.outcomeList[0];

    tdSelectString = '1st';


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
                "Malaria Register",
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

                //pre session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          'Channel',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(containerWidth: 250, value: (String value, int index) {
                          channel = value;
                        }, options: AppConstants.clinicList, currentValue: channel,),

                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Service Site Name',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Service Site Nam', 1, nameController,10000),
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

                //date picker session
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

                    //Patient Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Patient Name',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Patient Name', 1, patientNameController,10000),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                //date picker session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //age
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Age (number only)',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Age (number only)', 1, ageController,3),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sex',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: SexRadioButton(
                                radioValue: (String value) {
                                  sex = value;
                                },
                                activeValue: sex,
                              )),
                        ],
                      ),
                    ),
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
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //disability session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'နေရပ်လိပ်စာ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('နေရပ်လိပ်စာ', 1, addressController,10000),
                      ],
                    ),

                    //extra space
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ကိုယ်ဝန်ဆောင်',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: MultiRadio(radioValue: (String value) {
                                pregnant = value;
                              }, activeValue: '',)),
                        ],
                      ),
                    ),
                    /*
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ကိုယ်ဝန်ဆောင်',
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
                                  pregnant = value;
                                },
                                activeValue: pregnant, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),
                    */

                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //ပိုလီယို (OPV/bOPV)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'RDT ဖြင့်စစ်ဆေး',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedOne,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedOne = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ဖယ်ဆီပါရမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedTwo,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedTwo = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ဗိုင်းဗိုက်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedThree,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedThree = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပိုးအရောတွေ့',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedFour,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedFour = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပိုးမတွေ့',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),


                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ပိုး‌တွေ့',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedNormal,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedNormal = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'သာမန်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      ],
                    ),

                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedStrong,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedStrong = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပြင်းထန်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),


                  ],
                ),

                const SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'ကုသပေးသော ငှက်ဖျားဆေး',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            //Three Check Box
                            const Text(
                              'အေစီတီ ၂၄',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),

                            small_inputBox('Amt', 1, act24Controller,100),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            //Three Check Box
                            const Text(
                              'အေစီတီ ၁၈',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),

                            small_inputBox('Amt', 1, act24Controller,100),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            //Three Check Box
                            const Text(
                              'အေစီတီ ၁၂',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            small_inputBox('Amt', 1, act24Controller,100),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            //Three Check Box
                            const Text(
                              'အေစီတီ ၆',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            small_inputBox('Amt', 1, act24Controller,100),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            //Three Check Box
                            const Text(
                              'ကလိုရိုကွင်း',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            small_inputBox('Amt', 1, act24Controller,100),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            //Three Check Box
                            const Text(
                              'ပရိုင်မာကွင်း',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            small_inputBox('Amt', 1, act24Controller,100),
                          ],
                        ),
                      ],
                    )


                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //date picker session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ဆေးရုံဆေးခန်းလွှဲပြောင်း',
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
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ငှက်ဖျားပိုးတွေ့သေဆုံး',
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
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ဆေးကုသမှုခံယူခြင်း',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 400,
                              child: CustomRadioButton(
                                radioValue: (String value) {
                                  treatment = value;
                                },
                                activeValue: treatment, radioList: const ['၂၄ နာရီအတွင်း','၂၄ နာရီကျော်'],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                //attended
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ခရီးသွားခြင်း ( ၂ ပတ် - ၁ လအတွင်း )',
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remark',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Remark', 3, remarkController,10000),
                      ],
                    ),

                    SizedBox(
                      width: 200,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 600,
                    child: Row(
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
                              if (nameController.text.isEmpty||
                                  ageController.text.isEmpty ||
                                  gestationalWeekController.text.isEmpty||
                                  gravidaController.text.isEmpty ||
                                  parityController.text.isEmpty ||
                                  findingsController.text.isEmpty ||
                                  treatmentController.text.isEmpty ||
                                  attendedby.isEmpty ||
                                  outcome.isEmpty ||
                                  villageNameController.text.isEmpty ||
                                  reportingPeriod.isEmpty ||
                                  channel.isEmpty ||
                                  tdSelectString.isEmpty ) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Center(
                                      child: Text('Sorry!! Please input empty fields'),
                                    )));
                              } else {
                                //Check Validation for Age
                                var age = int.parse(ageController.text);
                                var gestation = int.parse(gestationalWeekController.text);
                                var gravida = int.parse(gravidaController.text);
                                var parity = int.parse(parityController.text);
                                if (age > 0 && age < 101) {

                                  if (gestation > 0 && gestation < 43){

                                    if (gravida > 0 && gravida < 21){

                                      if (parity > -1 && parity < 21){

                                        //Add To DB
                                        ANCVo dataVo = ANCVo(
                                            tableName: AppConstants.ancTable,
                                            orgName: PreferenceManager.getString(ORG),
                                            stateName: PreferenceManager.getString(STATE),
                                            townshipName: PreferenceManager.getString(REGION),
                                            townshipLocalName: PreferenceManager.getString(REGION_LOCAL),
                                            clinic: villageNameController.text,
                                            channel: channel,
                                            reportingPeroid: reportingPeriod,
                                            date: date,
                                            name: nameController.text,
                                            age: ageController.text,
                                            disability: disabled,
                                            idp: idp,
                                            gestational: gestationalWeekController.text,
                                            gravida: gravidaController.text,
                                            parity: parityController.text,
                                            noOfANC: nOfANCVisitController.text,
                                            td: tdSelectString,
                                            findings: findingsController.text,
                                            treatment: treatmentController.text,
                                            ancfour: ancFour,
                                            attended: attendedby,
                                            outcome: outcome,
                                            remark: remarkController.text,
                                            createDate: todayDateString,
                                            updateDate: todayDateString);

                                        try {
                                          //PreferenceManager.setString(CLINIC, clinicTeamController.text);
                                          PreferenceManager.setString(CHANNEL, channel);
                                          PreferenceManager.setString(REPORT_PERIOD, reportingPeriod);
                                          //  DatabaseProvider provider = DatabaseProvider.db;
                                          // provider.insertACNDataToDB(dataVo);
                                          helper.insertACNDataToDB(dataVo,false);

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      HomeScreen(indexOfTab: 0, selectedSideIndex: 0,)));
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
                                              child: Text('Parity should be 0 to 20 !!!'),
                                            )));

                                      }


                                    }else{
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Center(
                                            child: Text('Gravida should be 1 to 20 !!!'),
                                          )));
                                    }



                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Center(
                                          child: Text('Gestational Week should be 1 to 42 weeks !!!'),
                                        )));
                                  }


                                }else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Center(
                                        child: Text('Age should be between 1 to 100 years !!!'),
                                      )));

                                }

                              }
                            })
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
        child: controller == ageController ||
            controller == gestationalWeekController ||
            controller == gravidaController ||
            controller == parityController ||
            controller == nOfANCVisitController
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

  SizedBox small_inputBox(
      String title, int maxlines, TextEditingController controller, int limit) {

    return SizedBox(
      width: 80,
      height: 50,
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(5),
        ],
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          labelText: title,
        ),
      ),
    );


  }

}
