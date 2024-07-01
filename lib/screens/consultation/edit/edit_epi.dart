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
                    //dorp down
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
                        DropdownListView(containerWidth: 250,
                          value: (String value, int index) {
                          bcgValue = value;
                          }, options: AppConstants.bcgList, currentValue: bcgValue,),
                      ],
                    ),
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
                    width: 300,
                    child: ButtonWidget(
                        buttonText: 'Save',
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
                                  bcg: bcgValue,
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
