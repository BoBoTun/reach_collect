import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/anc_model.dart';
import 'package:reach_collect/network/presistance/SQLiteHelper.dart';
import 'package:reach_collect/screens/home_screen.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/button_widget.dart';
import 'package:reach_collect/widgets/date_picker.dart';
import 'package:reach_collect/widgets/radio_button.dart';

import '../../../data/model/epi_model.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/preference_keys.dart';
import '../../../utils/share_preference.dart';
import '../../../widgets/custom_dropdown_widget.dart';
import '../../../widgets/custom_radio.dart';
import '../../../widgets/month_picker.dart';
import '../../../widgets/tdDropdown.dart';
import '../../../widgets/textfield_widget.dart';

class EditEPI extends StatefulWidget {
  const EditEPI({super.key, required this.reachCollectVo});
  final EPIVo reachCollectVo;

  @override
  State<EditEPI> createState() => _EditEPICState();
}

class _EditEPICState extends State<EditEPI> {
  String date = '';
  String date_of_birth = '';
  String gender = '';
  String disabled = '';
  String relocation = '';
  String bcgValue = '';
  String isPrevent = '';
  String isRefer = '';
  String handOverValue = '';

  String reportingPeriod = '';
  String channel = '';
  String todayDateString = '';

  String? _selectedKey;
  String? _selectedItem;

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

  final TextEditingController orgController = TextEditingController();
  final TextEditingController townshipLocalController = TextEditingController();

  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    super.initState();

    gender = widget.reachCollectVo.sex ?? '';
    date_of_birth = widget.reachCollectVo.dob ?? '';
    disabled = widget.reachCollectVo.disabled ?? '';
    relocation = widget.reachCollectVo.relocation ?? '';
    bcgValue = widget.reachCollectVo.bcg ?? '';
    isPrevent = widget.reachCollectVo.vaccined ?? '';
    isRefer = widget.reachCollectVo.refer ?? '';
    handOverValue = widget.reachCollectVo.referPlace ?? '';

    nameController.text = widget.reachCollectVo.childName ?? '';
    remarkController.text = widget.reachCollectVo.remark ?? '';
    addressController.text = widget.reachCollectVo.address ?? '';


    clinicTeamController.text = widget.reachCollectVo.clinic ?? '';//PreferenceManager.getString(CLINIC) ?? '';
    channel = widget.reachCollectVo.channel ?? '';//PreferenceManager.getString(CHANNEL) ?? '';
    reportingPeriod = widget.reachCollectVo.reportingPeroid ?? '';//PreferenceManager.getString(REPORT_PERIOD) ?? date;

    DateTime todayDate = DateTime.now();
    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);

    orgController.text = widget.reachCollectVo.orgName ?? '';
    townshipLocalController.text = widget.reachCollectVo.townshipLocalName ?? '';

    _selectedKey = widget.reachCollectVo.stateName ?? '';
    _selectedItem = widget.reachCollectVo.townshipName ?? '';

    bcg_date = widget.reachCollectVo.bcg ?? "${todayDate.toLocal()}".split(' ')[0];

    String opv_date = widget.reachCollectVo.opv ?? '';
    String penta_date = widget.reachCollectVo.penta ?? '';
    String mmr_date = widget.reachCollectVo.mmr ?? '';
    String je_date = widget.reachCollectVo.je ?? '';

    List opvList =  opv_date.split('|');
    List penList =  penta_date.split('|');
    List mmrList =  mmr_date.split('|');
    List jeList =  je_date.split('|');

    opv_date1 = opvList.length > 0 ? opvList[0] : "${todayDate.toLocal()}".split(' ')[0];
    penta_date1 = penList.length > 0 ? penList[0] : "${todayDate.toLocal()}".split(' ')[0];
    mmr_date1 = mmrList.length > 0 ? mmrList[0] : "${todayDate.toLocal()}".split(' ')[0];
    je_date1 = jeList.length > 0 ? jeList[0] : "${todayDate.toLocal()}".split(' ')[0];

    opv_date2 = opvList.length > 1 ? opvList[1] : "${todayDate.toLocal()}".split(' ')[0];
    penta_date2 = penList.length > 1 ? penList[1] : "${todayDate.toLocal()}".split(' ')[0];
    mmr_date2 = mmrList.length > 1 ? mmrList[1] : "${todayDate.toLocal()}".split(' ')[0];
    je_date2 = jeList.length > 1 ? jeList[1] : "${todayDate.toLocal()}".split(' ')[0];

    opv_date3 = opvList.length > 2 ? opvList[2] : "${todayDate.toLocal()}".split(' ')[0];
    penta_date3 = penList.length > 2 ? penList[2] : "${todayDate.toLocal()}".split(' ')[0];
    mmr_date3 = mmrList.length > 2 ? mmrList[2] : "${todayDate.toLocal()}".split(' ')[0];
    je_date3 = jeList.length > 2 ? jeList[2] : "${todayDate.toLocal()}".split(' ')[0];

    _isCheckedBCG = widget.reachCollectVo.bcg != null ? true : false;

    _isCheckedOPV1 = opvList.length > 0 ? true : false;
    _isCheckedOPV2 = opvList.length > 1 ? true : false;
    _isCheckedOPV3 = opvList.length > 2 ? true : false;

    _isCheckedPenta1 = penList.length > 0 ? true : false;
    _isCheckedPenta2 = penList.length > 1 ? true : false;
    _isCheckedPenta3 = penList.length > 2 ? true : false;

    _isCheckedMMR1 = mmrList.length > 0 ? true : false;
    _isCheckedMMR2 = mmrList.length > 1 ? true : false;
    _isCheckedMMR3 = mmrList.length > 2 ? true : false;

    _isCheckedJE1 = jeList.length > 0 ? true : false;
    _isCheckedJE2 = jeList.length > 1  ? true : false;
    _isCheckedJE3 = jeList.length > 2 ? true : false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: AppTheme.secondaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
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
                "EPI",
                style: AppTheme.navigationTitleStyle,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
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

                    //Child Name
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
                                      id: widget.reachCollectVo.id,
                                      tableName: AppConstants.epiTable,
                                      orgName: orgController.text,
                                      stateName: _selectedKey,
                                      townshipName: _selectedItem,
                                      townshipLocalName: townshipLocalController.text,
                                      clinic: clinicTeamController.text,
                                      channel: channel,
                                      reportingPeroid: reportingPeriod,
                                      childName: nameController.text,
                                      sex: gender,
                                      disabled: disabled,
                                      relocation: relocation,
                                      address: addressController.text,
                                      dob: date_of_birth,
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

                                    //  DatabaseProvider provider = DatabaseProvider.db;
                                    // provider.insertACNDataToDB(dataVo);
                                    helper.updateEPIInto(dataVo);

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
