import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reach_collect/data/model/anc_model.dart';
import 'package:reach_collect/data/model/srh_model.dart';
import 'package:reach_collect/network/presistance/SQLiteHelper.dart';
import 'package:reach_collect/screens/home_screen.dart';
import 'package:reach_collect/utils/app_constant.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/utils/preference_keys.dart';
import 'package:reach_collect/utils/share_preference.dart';
import 'package:reach_collect/widgets/button_widget.dart';
import 'package:reach_collect/widgets/custom_dropdown_widget.dart';
import 'package:reach_collect/widgets/date_picker.dart';
import 'package:reach_collect/widgets/male_female_radio.dart';
import 'package:reach_collect/widgets/radio_button.dart';

import '../../widgets/month_picker.dart';

class SRHRegisterScreen extends StatefulWidget {
  const SRHRegisterScreen({super.key});

  @override
  State<SRHRegisterScreen> createState() => _SRHRegisterScreenState();
}

class _SRHRegisterScreenState extends State<SRHRegisterScreen> {
  final SQLiteHelper helper = SQLiteHelper();
  //data var
  String date = '';
  String disability = 'true';
  String idp = 'true';
  String attended = '';
  String outcome = '';
  String clinicTeam = '';
  String reportingPeriod = '';
  String tdSelectString = '1St';
  String tdSelectedDate = '';
  String sex = 'Male';
  String firstWeek = 'true';
  String serviceType = '';
  String channel = '';
  String todayDateString = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController clinicTeamController = TextEditingController();
  TextEditingController fpComndityController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime todayDate = DateTime.now();

    date = "${todayDate.toLocal()}".split(' ')[0];
    tdSelectedDate = "${todayDate.toLocal()}".split(' ')[0];

    clinicTeamController.text = PreferenceManager.getString(CLINIC) ?? '';
    channel = PreferenceManager.getString(CHANNEL) ?? '';
    reportingPeriod = PreferenceManager.getString(REPORT_PERIOD) ?? date;

    serviceType = AppConstants.serviceTypeList[0];
    attended = AppConstants.attandedList[0];
    outcome = AppConstants.attandedList[0];

    todayDateString = DateFormat('yyyy-MM-dd - kk-mm-ss').format(todayDate);
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
                "SRH Register",
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

                //date picker session
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
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            channel = value;
                          },
                          options: AppConstants.channelList,
                          currentValue: channel.isEmpty
                              ? AppConstants.channelList[0]
                              : channel,
                        ),
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

                //date picker session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Name', 1, nameController,10000),
                      ],
                    ),

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
                    )
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
                            'Disability',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  disability = value;
                                },
                                activeValue: disability,
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
                            'IDP',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  idp = value;
                                },
                                activeValue: idp,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                //ges week
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Service Type',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            serviceType = value;
                          },
                          options: AppConstants.serviceTypeList,
                          currentValue: AppConstants.serviceTypeList[0],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'First reach this year',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 50,
                            width: 200,
                            child: HorizontalRadioButton(
                              radioValue: (String value) {
                                firstWeek = value;
                              },
                              activeValue: firstWeek,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'FP Commodity',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          inputBox('FP Commodity', 1, fpComndityController,10000)
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          inputBox('Quantity', 1, quantityController,100)
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Findings',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Findings and provisional diagnosis', 1, findingsController,10000),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Treatment',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          inputBox('Treatment', 1, treatmentController,10000),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
                //finding
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Attended by',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            attended = value;
                          },
                          options: AppConstants.attandedList,
                          currentValue: AppConstants.attandedList[0],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Outcome',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownListView(
                          containerWidth: 250,
                          value: (String value, int index) {
                            outcome = value;
                          },
                          options: AppConstants.outcomeList,
                          currentValue: AppConstants.outcomeList[0],
                        ),
                      ],
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
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //attended

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
                          if (nameController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              fpComndityController.text.isEmpty ||
                              quantityController.text.isEmpty ||
                              findingsController.text.isEmpty ||
                              treatmentController.text.isEmpty ||
                              channel.isEmpty ||
                              clinicTeamController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Center(
                              child: Text('Sorry!! Please input empty fields'),
                            )));
                          } else {
                            var age = int.parse(ageController.text);

                            if (age > 0 && age < 101) {
                              SRHVo dataVo = SRHVo(
                                  tableName: AppConstants.srhTable,
                                  orgName: PreferenceManager.getString(ORG),
                                  stateName: PreferenceManager.getString(STATE),
                                  townshipName:
                                  PreferenceManager.getString(REGION),
                                  townshipLocalName:
                                  PreferenceManager.getString(REGION_LOCAL),
                                  clinic: clinicTeamController.text,
                                  channel: channel,
                                  reportingPeroid: reportingPeriod,
                                  date: date,
                                  name: nameController.text,
                                  age: ageController.text,
                                  sex: sex,
                                  disability: disability,
                                  iDP: idp,
                                  serviceType: serviceType,
                                  firstReach: firstWeek,
                                  fpCommodity: fpComndityController.text,
                                  quantity: quantityController.text,
                                  fnpDiagnosis: findingsController.text,
                                  treatment: treatmentController.text,
                                  attended: attended,
                                  outcome: outcome,
                                  remark: remarkController.text,
                              createDate: todayDateString,
                              updateDate: todayDateString);

                              try {
                                //DatabaseProvider provider = DatabaseProvider.db;
                                helper.insertSRHDataToDB(dataVo,false);

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                    builder: (builder) => HomeScreen(
                                      indexOfTab: 2, selectedSideIndex: 0,
                                    )));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Center(
                                      child: Text('Something wrong!!'),
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
                        }),
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
        child: controller == ageController
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
}
