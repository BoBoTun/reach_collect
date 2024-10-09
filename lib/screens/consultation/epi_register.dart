import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/epi_model.dart';

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
import '../../widgets/month_picker.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/tdDropdown.dart';
import '../home_screen.dart';

class EPIRegister extends StatefulWidget {
  const EPIRegister({super.key});

  @override
  State<EPIRegister> createState() => _EPIRegisterState();
}

class _EPIRegisterState extends State<EPIRegister> {

  //data var
  String date = '';
  String date_of_birth = '';
  String gender = 'ကျား';
  String disabled = 'Yes';
  String relocation = 'Yes';
  String bcgValue = AppConstants.bcgList[0];
  String isPrevent = 'Yes';
  String isRefer = 'Yes';
  String handOverValue = '';

  String reportingPeriod = '';
  String channel = '';
  String todayDateString = '';
  String bcg_date = '';

  String opv_date1 = '';
  String penta_date1 = '';
  String mmr_date1 = '';
  String je_date1 = '';

  String opv_date2 = '';
  String penta_date2 = '';
  String mmr_date2 = '';
  String je_date2 = '';

  String opv_date3 = '';
  String penta_date3 = '';
  String mmr_date3 = '';
  String je_date3 = '';

  bool _isCheckedBCG = false;

  bool _isCheckedOPV1 = false;
  bool _isCheckedOPV2 = false;
  bool _isCheckedOPV3 = false;

  bool _isCheckedPenta1 = false;
  bool _isCheckedPenta2 = false;
  bool _isCheckedPenta3 = false;

  bool _isCheckedMMR1 = false;
  bool _isCheckedMMR2 = false;
  bool _isCheckedMMR3 = false;

  bool _isCheckedJE1 = false;
  bool _isCheckedJE2 = false;
  bool _isCheckedJE3 = false;

  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  final SQLiteHelper helper = SQLiteHelper();


  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];
    date_of_birth = "${todayDate.toLocal()}".split(' ')[0];
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);
    bcg_date = "${todayDate.toLocal()}".split(' ')[0];

    opv_date1 = "${todayDate.toLocal()}".split(' ')[0];
    penta_date1 = "${todayDate.toLocal()}".split(' ')[0];
    mmr_date1 = "${todayDate.toLocal()}".split(' ')[0];
    je_date1 = "${todayDate.toLocal()}".split(' ')[0];

    opv_date2 = "${todayDate.toLocal()}".split(' ')[0];
    penta_date2 = "${todayDate.toLocal()}".split(' ')[0];
    mmr_date2 = "${todayDate.toLocal()}".split(' ')[0];
    je_date2 = "${todayDate.toLocal()}".split(' ')[0];

    opv_date3 = "${todayDate.toLocal()}".split(' ')[0];
    penta_date3 = "${todayDate.toLocal()}".split(' ')[0];
    mmr_date3 = "${todayDate.toLocal()}".split(' ')[0];
    je_date3 = "${todayDate.toLocal()}".split(' ')[0];

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = PreferenceManager.getString(CHANNEL) ?? '';
    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    handOverValue = AppConstants.handoverList[0];


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
                "EPI Register",
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
                          'Clinic/Team',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Clinic/Team', 1, clinicTeamController,10000),
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
                        }, options: AppConstants.channelList, currentValue: channel.isEmpty ? AppConstants.channelList[0] : channel,),
                      ],
                    ),
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

                    //Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ကလေး အမည်',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('ကလေး အမည်', 1, nameController,10000),
                      ],
                    ),
                    //Male/Female
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

                //Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Male/Female
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'မွေးနေ့',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            date_of_birth = dateString;
                          },
                          updateDateString: date_of_birth,
                        ),
                      ],
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

                    //BCG
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ဘီစီဂျီ (BCG)',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Checkbox(
                          value: _isCheckedBCG,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckedBCG = value!;
                            });
                          },
                          activeColor: AppTheme.secondaryColor,
                          checkColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            bcg_date = dateString;
                          },
                          updateDateString: bcg_date,
                        ),
                      ],
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

                    //ပိုလီယို (OPV/bOPV)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ပိုလီယို (OPV/bOPV)',
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
                              value: _isCheckedOPV1,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedOPV1 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပထမအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            opv_date1 = dateString;
                          },
                          updateDateString: opv_date1,
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
                              value: _isCheckedOPV2,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedOPV2 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ဒုတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            opv_date2 = dateString;
                          },
                          updateDateString: opv_date2,
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
                              value: _isCheckedOPV3,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedOPV3 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'တတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            opv_date3 = dateString;
                          },
                          updateDateString: opv_date3,
                        ),
                      ],
                    ),


                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //Row 3.1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //ငါးမျိုးစပ်ကာကွယ်ဆေး
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ငါးမျိုးစပ်ကာကွယ်ဆေး \n (Penta/ DPT-HepB-Hib)',
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
                              value: _isCheckedPenta1,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedPenta1 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပထမအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            penta_date1 = dateString;
                          },
                          updateDateString: penta_date1,
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 70,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedPenta2,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedPenta2 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ဒုတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            penta_date2 = dateString;
                          },
                          updateDateString: penta_date2,
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 70,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedPenta3,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedPenta3 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'တတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            penta_date3 = dateString;
                          },
                          updateDateString: penta_date3,
                        ),
                      ],
                    ),


                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //Row 3.2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //ပပါးချိတ်ယောင်၊ ဝက်သက်၊ ဂျိုက်သိုး (MMR)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ပါးချိတ်ယောင်၊ ဝက်သက်၊ \nဂျိုက်သိုး (MMR)',
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
                              value: _isCheckedMMR1,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedMMR1 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပထမအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            mmr_date1 = dateString;
                          },
                          updateDateString: mmr_date1,
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedMMR2,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedMMR2 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ဒုတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            mmr_date2 = dateString;
                          },
                          updateDateString: mmr_date2,
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),

                        //Three Check Box
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedMMR3,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedMMR3 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'တတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            mmr_date3 = dateString;
                          },
                          updateDateString: mmr_date3,
                        ),
                      ],
                    ),


                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                //Row 3.3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //ပပါးချိတ်ယောင်၊ ဝက်သက်၊ ဂျိုက်သိုး (MMR)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ဂျပန် ဦးနှောက်ရောင် (JE)',
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
                              value: _isCheckedJE1,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedJE1 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ပထမအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            je_date1 = dateString;
                          },
                          updateDateString: je_date1,
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
                              value: _isCheckedJE2,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedJE2 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'ဒုတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            je_date2 = dateString;
                          },
                          updateDateString: je_date2,
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
                              value: _isCheckedJE3,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedJE3 = value!;
                                });
                              },
                              activeColor: AppTheme.secondaryColor,
                              checkColor: Colors.white,
                            ),
                            const Text(
                              'တတိယအကြိမ်',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          dateString: (dateString) {
                            je_date3 = dateString;
                          },
                          updateDateString: je_date3,
                        ),
                      ],
                    ),


                  ],
                ),

                const SizedBox(
                  height: 40,
                ),
                //Row 3.4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Is Prevent
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ကာကွယ်ဆေး အပြည့်ထိုးပြီး',
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
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  isRefer = value;
                                },
                                activeValue: isRefer, radioList: ['Yes','No'],
                              )),
                        ],
                      ),
                    ),//
                    // dorp down
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
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),
                //Row 4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

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

                    SizedBox(width: 250,)
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
                                    addressController.text.isEmpty ||
                                    clinicTeamController.text.isEmpty ||
                                    reportingPeriod.isEmpty ||
                                    channel.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Center(
                                        child: Text('Sorry!! Please input empty fields'),
                                      )));
                                } else {

                                  String bcg = "";
                                  String opv = "";
                                  String penta = "";
                                  String mmr = "";
                                  String je = "";

                                  print("BCG CHECK :: $_isCheckedBCG");

                                  if (_isCheckedBCG){
                                    print("BCG DATE $bcg_date");
                                    bcg = bcg_date;
                                  }

                                  if (_isCheckedOPV1){
                                    opv = opv_date1;
                                  }
                                  if (_isCheckedOPV2){
                                    opv += "|$opv_date2";
                                  }
                                  if (_isCheckedOPV3){
                                    opv += "|$opv_date3";
                                  }

                                  if (_isCheckedPenta1){
                                    penta = penta_date1;
                                  }
                                  if (_isCheckedPenta2){
                                    penta += "|$penta_date2";
                                  }
                                  if (_isCheckedPenta3){
                                    penta += "|$penta_date3";
                                  }

                                  if (_isCheckedMMR1){
                                    mmr = mmr_date1;
                                  }
                                  if (_isCheckedMMR2){
                                    mmr += "|$mmr_date2";
                                  }
                                  if (_isCheckedMMR3){
                                    mmr += "|$mmr_date3";
                                  }

                                  if (_isCheckedJE1){
                                    je = je_date1;
                                  }
                                  if (_isCheckedJE2){
                                    je += "|$je_date2";
                                  }
                                  if (_isCheckedJE3){
                                    je += "|$je_date3";
                                  }
                                  //Add To DB
                                  EPIVo dataVo = EPIVo(
                                      tableName: AppConstants.epiTable,
                                      orgName: PreferenceManager.getString(ORG),
                                      stateName: PreferenceManager.getString(STATE),
                                      townshipName: PreferenceManager.getString(REGION),
                                      townshipLocalName: PreferenceManager.getString(REGION_LOCAL),
                                      clinic: clinicTeamController.text,
                                      channel: channel,
                                      reportingPeroid: reportingPeriod,
                                      childName: nameController.text,
                                      sex: gender,
                                      disabled: disabled,
                                      relocation: relocation,
                                      address: addressController.text,
                                      dob: date,
                                      bcg: bcg,
                                      opv: opv,
                                      penta: penta,
                                      mmr: mmr,
                                      je: je,
                                      vaccined: isPrevent,
                                      refer: isRefer,
                                      referPlace: handOverValue,
                                      remark: remarkController.text,
                                      createDate: todayDateString,
                                      updateDate: todayDateString
                                  );

                                  try {
                                    PreferenceManager.setString(CLINIC, clinicTeamController.text);
                                    PreferenceManager.setString(CHANNEL, channel);
                                    PreferenceManager.setString(REPORT_PERIOD, reportingPeriod);
                                    //  DatabaseProvider provider = DatabaseProvider.db;
                                    // provider.insertACNDataToDB(dataVo);
                                    helper.insertEPIDataToDB(dataVo,false);

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                HomeScreen(indexOfTab: 0, selectedSideIndex: 1,)));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Center(
                                          child: Text('Something wrong!!'),
                                        )));
                                  }

                                  //End add to DB

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
        child: TextField(
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

}
